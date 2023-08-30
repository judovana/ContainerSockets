#!/bin/bash
set -xeo pipefail

## cleaning any existing podman images and containers
if [ "x$clean" == "xtrue" ] ; then
  podman rmi -a -f
  podman rm -a -f
  podman ps -all
  podman images
fi

set -u

FEDORA_VERSION=fedora:38
preparation_dockerfile=docekrfile.tmp
echo "FROM $FEDORA_VERSION" > $preparation_dockerfile
echo 'RUN dnf -y install /usr/bin/javac' >> $preparation_dockerfile
echo "COPY runlocal.sh ." >> $preparation_dockerfile
echo "COPY src src " >> $preparation_dockerfile
echo "RUN ls -l ." >> $preparation_dockerfile
echo "RUN pwd " >> $preparation_dockerfile

podman build --tag run-incont-sockets -f ./$preparation_dockerfile
podman run --name sockets run-incont-sockets bash runlocal.sh false
#podman run -it --name sockets run-incont-sockets  bash
