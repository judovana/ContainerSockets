#!/bin/bash
set -x

rm -vf coso/Main.class
rmdir -v coso

set -euo pipefail

javac -source 8 -target 8  -d .  src/coso/Main.java

echo "if you see hostname error 2 in contianer, its ok, hostname is not mandatory"
java coso/Main server 1455 &
sleep 1
java coso/Main client 1455 localhost &
sleep 1
echo "if you see this fail in contianer, its ok, hostname is not mandatory"
java coso/Main client 1455 `hostname` &
set +ux
if [ "x$1" == "xfalse" ] ; then
  while true ; do sleep 1 ; done
fi