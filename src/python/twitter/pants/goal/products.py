from collections import defaultdict

class Products(object):
  class ProductMapping(object):
    """
      Maps products of a given type by target.  Its assumed that all products of a given type for
      a given target are emitted to a single base directory.
    """

    def __init__(self, typename):
      self.typename = typename
      self.by_target = defaultdict(lambda: defaultdict(list))

    def add(self, target, basedir, product_paths=None):
      """
        Adds a mapping of products for the given target, basedir pair.

        If product_paths are specified, these will over-write any existing mapping for this target.

        If product_paths is omitted, the current mutable list of mapped products for this target
        and basedir is returned for appending.
      """
      if product_paths is not None:
        self.by_target[target][basedir].extend(product_paths)
      else:
        return self.by_target[target][basedir]

    def get(self, target):
      """
        Returns the product mapping for the given target as a tuple of (basedir, products list).
        Can return None if there is no mapping for the given target.
      """
      return self.by_target.get(target)

    def keys_for(self, basedir, file):
      """Returns the set of keys the given mapped product is registered under."""
      keys = set()
      for key, mappings in self.by_target.items():
        for mapped in mappings.get(basedir, []):
          if file == mapped:
            keys.add(key)
            break
      return keys

    def __repr__(self):
      return 'ProductMapping(%s) {\n  %s\n}' % (self.typename, '\n  '.join(
        '%s => %s\n    %s' % (str(target), basedir, outputs)
                              for target, outputs_by_basedir in self.by_target.items()
                              for basedir, outputs in outputs_by_basedir.items()))

  def __init__(self):
    self.products = {}
    self.predicates_for_type = defaultdict(list)

  def require(self, typename, predicate=None):
    """
      Registers a requirement that products of the given type by mapped.  If a target predicate is
      supplied, only targets matching the predicate are mapped.
    """
    if predicate:
      self.predicates_for_type[typename].append(predicate)
    return self.products.setdefault(typename, Products.ProductMapping(typename))

  def isrequired(self, typename):
    """
      Returns a predicate that selects targets required for the given type if mappings are
      required.  Otherwise returns None.
    """
    if typename not in self.products:
      return None
    def combine(first, second):
      return lambda target: first(target) or second(target)
    return reduce(combine, self.predicates_for_type[typename], lambda target: False)

  def get(self, typename):
    """Returns a ProductMapping for the given type name."""
    return self.require(typename)
