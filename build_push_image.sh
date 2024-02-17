#!/bin/bash

## Create function common to make output looks clean 
common () {
sleep 5
clear
}

## Create function build to building image from dockerfile
build () {
echo "Build image from Dockerfile"
echo "---------------------------"
echo ""
docker build --tag item-app:v1 -f /home/sysadmin/a433-microservices/Dockerfile .
}

## Create function list to listing available local image
list () {
echo "List images on local registry"
echo "-----------------------------"
echo ""
docker image ls
}

## Create function name to rename or formatting image label/tag to match Dockerhub convention naming/tagging
name () {
echo "Change image name to match DockerHub naming format"
echo "--------------------------------------------------"
echo ""
docker tag $(docker image ls | grep -E 'item-app|v1' | awk '{print $3}'|tail -1) agus3rdyoga/item-app:v1
}

## Create function login to login to dockerhub using provided token stored on ~/.bashrc & exported as $TOKEN_DOCKER_HUB variable
login () {
echo "Login to docker hub"
echo "-------------------"
echo ""
echo $TOKEN_DOCKER_HUB | docker login -u agus3rdyoga --password-stdin 
}

## Create function upload to upload final image to dockerhub 
upload () {
echo "Upload image to docker hub"
echo "--------------------------"
echo ""
docker push agus3rdyoga/item-app:v1
}

## Run all function in sequence following the rules from Dicoding material 
clear
build
common
list
common
name
list
common
login
common
upload
common
list