<?xml version="1.0"?>

<!--
=================================================================================================
Copyright 2011 Twitter, Inc.
_________________________________________________________________________________________________
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

 http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
=================================================================================================
-->

<!-- generated by pants! -->
<module type="JAVA_MODULE" version="4">
  <component name="FacetManager">
    % if module.has_python:
    <facet type="Python" name="Python"/>
    % endif

    % if module.has_scala:
    <facet type="scala" name="Scala">
      <configuration>
        <option name="compilerLibraryLevel" value="Project"/>
        <option name="compilerLibraryName" value="scala"/>
      </configuration>
    </facet>
    % endif

    % if module.has_bash:
    <facet type="bash" name="BashSupport"/>
    % endif
  </component>
  <component name="NewModuleRootManager" inherit-compiler-output="true">
    <exclude-output/>

    <content url="file://${module.root_dir}">
      <excludeFolder url="file://$MODULE_DIR$/external-libs" />
      <excludeFolder url="file://$MODULE_DIR$/external-libsources" />
      <excludeFolder url="file://$MODULE_DIR$/internal-libs" />
      <excludeFolder url="file://$MODULE_DIR$/internal-libsources" />
    </content>

    % for content_root in module.content_roots:
    <content url="file://${module.root_dir}/${content_root.path}">
      % for sources in content_root.sources:
        % if sources.package_prefix:
      <sourceFolder url="file://${module.root_dir}/${sources.path}"
                    isTestSource="${sources.is_test}"
                    packagePrefix="${sources.package_prefix}"/>
        % else:
      <sourceFolder url="file://${module.root_dir}/${sources.path}"
                    isTestSource="${sources.is_test}"/>
        % endif
      % endfor
      % for exclude_path in content_root.exclude_paths:
      <excludeFolder url="file://${module.root_dir}/${exclude_path}"/>
      % endfor
    </content>
    % endfor

    <orderEntry type="inheritedJdk"/>
    <orderEntry type="sourceFolder" forTests="false"/>
    % if module.has_scala:
    <orderEntry type="library" name="scala" level="project"/>
    % endif
    <orderEntry type="module-library">
      <library name="internal">
        <CLASSES>
          % for jar in module.internal_jars:
          <root url="jar://${jar}!/" />
          % endfor
        </CLASSES>
        <JAVADOC />
        <SOURCES>
          % for source_jar in module.internal_source_jars:
          <root url="jar://${source_jar}!/" />
          % endfor
        </SOURCES>
      </library>
    </orderEntry>
    <orderEntry type="module-library">
      <library name="external">
        <CLASSES>
          % for jar in module.external_jars:
          <root url="jar://${jar}!/" />
          % endfor
        </CLASSES>
        <JAVADOC />
        <SOURCES>
          % for source_jar in module.external_source_jars:
          <root url="jar://${source_jar}!/" />
          % endfor
        </SOURCES>
      </library>
    </orderEntry>
  </component>

% for component in module.extra_components:
  ${component}

% endfor
</module>