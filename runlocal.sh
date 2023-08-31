#!/bin/bash
set -x

rm -vf coso/Main.class
rmdir -v coso
cat /etc/hosts

set -eo pipefail

finish=$1
messetc=$2

set -u

javac -source 8 -target 8  -d .  src/coso/Main.java

host1=localhost
echo "if you see this fail in contianer, its ok, hostname is not mandatory"
host2=`hostname` || true

# containers only?
if [ "x$messetc" == "xtrue" ] ; then
  host2=`cat /etc/hosts | grep -v "^#" | tail -n1 | sed "s/.* //"`
fi

echo "if you see hostname error 2 in contianer, its ok, hostname is not mandatory"
java coso/Main server 1455 &
sleep 1
java coso/Main client 1455 $host1 &
sleep 1
java coso/Main client 1455 $host2 &

set +ux
if [ "x$finish" == "xfalse" ] ; then
  while true ; do sleep 1 ; done
fi
