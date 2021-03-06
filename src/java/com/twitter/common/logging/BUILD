# ==================================================================================================
# Copyright 2011 Twitter, Inc.
# --------------------------------------------------------------------------------------------------
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this work except in compliance with the License.
# You may obtain a copy of the License in the LICENSE file, or at:
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==================================================================================================



java_library(name = 'logging',
  provides = artifact(
    org = 'com.twitter.common',
    name = 'logging',
    repo = pants('build-support/commons/ivy:public'),
  ),
  dependencies = [
    pants('3rdparty:commons-lang'),
    pants('3rdparty:guava'),
    pants('3rdparty:joda-time'),
  ],
  sources = [
    'Log.java',
    'LogUtil.java',
    'LogFormatter.java'
  ]
)

java_library(name = 'buffered',
  dependencies = [
    pants('3rdparty:guava'),
    pants(':logging'),
    pants('src/java/com/twitter/common/quantity'),
    pants('src/java/com/twitter/common/stats'),
  ],
  sources = [ 'BufferedLog.java' ]
)

java_library(name = 'scribe',
  provides = artifact(
    org = 'com.twitter.common',
    name = 'logging-scribe',
    repo = pants('build-support/commons/ivy:public'),
  ),
  dependencies = [
    pants('3rdparty:guava'),
    pants('3rdparty:thrift'),
    pants(':logging'),
    pants('src/java/com/twitter/common/quantity'),
    pants('src/java/com/twitter/common/thrift'),
    pants('src/thrift/org/apache/scribe:scribe_client-0.1.2'),
  ],
  sources = [ 'ScribeLog.java' ]
)
