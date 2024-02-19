#!/bin/bash

## Create function common to make output looks clean 
common () {
sleep 5
clear
}

## Create function build to building image from dockerfile
build () {
echo "Build image from Dockerfile"
echo -e "----------------------------\n\n"
docker build --tag karsajobs-ui:latest -f ./Dockerfile .
}

## Create function list to listing available local image
list () {
echo "List images on local registry"
echo -e "------------------------------\n\n"
docker image ls
}

## Create function name to rename or formatting image label/tag to match Dockerhub convention naming/tagging
name () {
echo "Change image name to match DockerHub naming format"
echo -e "---------------------------------------------------\n\n"
docker tag $(docker image ls | grep -E '^karsajobs-ui ' | awk '{print $3}'|tail -1) $DOCKERHUB_USERNAME/karsajobs-ui:latest
echo "Renaming docker image label..."
}

## Create function login to login to dockerhub using provided token stored on ~/.bashrc & exported as $TOKEN_DOCKER_HUB variable
login () {
echo "Login to docker hub"
echo -e "--------------------\n\n"
echo $DOCKERHUB_TOKEN | docker login -u $DOCKERHUB_USERNAME --password-stdin 
}

## Create function upload to upload final image to dockerhub 
upload () {
echo "Upload image to docker hub"
echo -e "---------------------------\n\n"
docker push $DOCKERHUB_USERNAME/karsajobs-ui:latest
}

## Run all function in sequence following the rules from Dicoding material 
clear
build
common
list
common
name
common
list
common
login
common
upload
common