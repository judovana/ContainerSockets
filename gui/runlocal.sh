#!/bin/bash
set -x

#all this mayhem with work dir is because of permissions inside containers with uuid in play
mkdir work
cd work
if [ ! -e src ] ; then
  cp -r ../src .
fi

rm -vf guisoc/Main.class
rmdir -v guisoc
set -eo pipefail

finish=$1

set -u

function run() {
  /usr/lib/jvm/java-1.8.0-openjdk/bin/javac -d .  src/guisoc/Main.java
  /usr/lib/jvm/java-1.8.0-openjdk/bin/java  guisoc/Main
  /usr/lib/jvm/java-11-openjdk/bin/javac    -d .  src/guisoc/Main.java
  /usr/lib/jvm/java-11-openjdk/bin/java     guisoc/Main
  /usr/lib/jvm/java-17-openjdk/bin/javac    -d .  src/guisoc/Main.java
  /usr/lib/jvm/java-17-openjdk/bin/java     guisoc/Main
}

if [ "x$finish" == "xno" ] ; then
  while true ; do
    run
  done
else
  run
fi


