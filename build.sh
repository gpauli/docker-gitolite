#!/bin/bash -e

echo "edit me !!!!" ; exit 1

mybase="docker.high-con.de/alpine-mini-amd64:3.9.2"
mytag="docker.high-con.de/gitolite:3.9.2"

echo "FROM $mybase" > Dockerfile
echo "MAINTAINER \"Gerd Pauli <gp@high-consulting.de>\"" >> Dockerfile
echo "RUN set -x && apk add --no-cache gitolite openssh tzdata && passwd -u git" >> Dockerfile
echo "RUN cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime" >> Dockerfile
echo "RUN echo \"Europe/Berlin\" >  /etc/timezone" >> Dockerfile
echo "RUN apk del tzdata" >> Dockerfile
echo "VOLUME [/etc/ssh/keys]" >> Dockerfile
echo "VOLUME [/var/lib/git]" >> Dockerfile
echo "COPY docker-entrypoint.sh /" >> Dockerfile
echo "ENTRYPOINT [\"/docker-entrypoint.sh\"]" >> Dockerfile
echo "EXPOSE 22" >> Dockerfile
echo "CMD [\"sshd\"]" >> Dockerfile
docker build -t makeit_debootstrap .
docker tag makeit_debootstrap $mytag 
docker rmi makeit_debootstrap






