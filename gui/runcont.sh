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

FEDORA_VERSION=fedora:36
preparation_dockerfile=docekrfile.tmp
echo "FROM $FEDORA_VERSION" > $preparation_dockerfile
echo 'RUN dnf -y install java-1.8.0-openjdk-devel java-11-openjdk-devel java-17-openjdk-devel' >> $preparation_dockerfile
echo "COPY runlocal.sh ." >> $preparation_dockerfile
echo "COPY src src " >> $preparation_dockerfile
echo "RUN pwd" >> $preparation_dockerfile
echo "RUN ls -l ." >> $preparation_dockerfile

podman build --tag run-incont-gui -f ./$preparation_dockerfile

xhost +"local:podman@" #<- normal user !!! mandatory
podman run -v /tmp/.X11-unix:/tmp/.X11-unix:ro -e "DISPLAY" --security-opt label=type:container_runtime_t --name gui run-incont-gui bash runlocal.sh
#podman run -it -v /tmp/.X11-unix:/tmp/.X11-unix:ro -e "DISPLAY" --security-opt label=type:container_runtime_t --name gui run-incont-gui bash
