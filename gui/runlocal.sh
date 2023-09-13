#!/bin/bash
set -x

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


