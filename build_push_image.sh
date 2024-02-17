#!/bin/bash

common () {
sleep 5
clear
}

build () {
echo "Build image from Dockerfile"
echo "---------------------------"
echo ""
podman build --tag item-app:v1 -f /home/sysadmin/a433-microservices/Dockerfile
}

list () {
echo "List images on local registry"
echo "-----------------------------"
echo ""
podman image ls
}

name () {
echo "Change image name to match DockerHub naming format"
echo "--------------------------------------------------"
echo ""
podman tag $(podman image ls | grep -E 'item-app|v1' | awk '{print $3}'|tail -1) agus3rdyoga/item-app:v1
podman image ls
}

login () {
echo "Login to docker hub"
echo "-------------------"
echo ""
echo $TOKEN_DOCKER_HUB | podman login -v docker.io -u agus3rdyoga --password-stdin 
}

upload () {
echo "Upload image to docker hub"
echo "--------------------------"
echo ""
podman push $(podman image ls | grep -E 'item-app|v1' | awk '{print $3}'|tail -1) docker://docker.io/agus3rdyoga/item-app:v1
}

clear
build
common
list
common
name
common
login
common
upload
common
list