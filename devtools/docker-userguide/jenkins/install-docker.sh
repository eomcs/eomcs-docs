#!/bin/sh

apt-get update

apt-get -y install apt-transport-https \
     apt-utils \
     ca-certificates \
     curl \
     gnupg2 \
     zip \
     unzip \
     acl \
     software-properties-common

curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \

apt-get update

apt-get -y install docker-ce
