#!/bin/bash
set -x

rm -vf xersoc/Main.class
rmdir -v xersoc
set -eo pipefail

finish=$1

set -u

rm -rf res-sed
cp -r res  res-sed
pushd res-sed
  CONFIG=/`pwd`/config_template.xml
  DIST_SYNC_CFG=`pwd`/dist-sync_template.xml
  sed -i "s;%{SLAVE_COUNT};1;;" ${CONFIG}
  sed -i "s;%{HEAP_SIZE};1000;g;" ${CONFIG}
  sed -i "s;%{NUM_THREADS};1;g;" ${CONFIG}
  sed -i "s;%{DIST_SYNC_CFG};${DIST_SYNC_CFG};g;" ${CONFIG}
  sed -i "s;%{CLUSTER_NAME};localhost-results;g;" ${DIST_SYNC_CFG}
popd


function run() {
  /usr/lib/jvm/java-1.8.0-openjdk/bin/javac -d .  src/xersoc/Main.java
  /usr/lib/jvm/java-1.8.0-openjdk/bin/java  xersoc/Main ${CONFIG}
  /usr/lib/jvm/java-11-openjdk/bin/javac    -d .  src/xersoc/Main.java
  /usr/lib/jvm/java-11-openjdk/bin/java     xersoc/Main ${CONFIG}
  /usr/lib/jvm/java-17-openjdk/bin/javac    -d .  src/xersoc/Main.java
  /usr/lib/jvm/java-17-openjdk/bin/java     xersoc/Main ${CONFIG}
}

if [ "x$finish" == "xno" ] ; then
  while true ; do
    run
  done
else
  run
fi


