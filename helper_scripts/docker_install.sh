#!/bin/bash -e

#Install docker
sudo apt-get update
sudo apt-get install -y curl
curl -fsSL https://get.docker.com/ | sh
docker --version

. docker_setup.sh