#!/bin/bash

MYSQL_USER=root
MYSQL_PASSWORD=root

DOCKER_IP=172.17.0.1
DOCKER_CONTAINER_NAME=ez-mysql
DOCKER_IMAGE_NAME=mysql:5.7.22
DOCKER_PORTS_EXPOSED=3306
#DOCKER_NETWORK=my-network

HOST_SHARED_FOLDER=/home/vladimir/docker-host/$DOCKER_CONTAINER_NAME


echo "Mysql user: $MYSQL_USER"
echo "Mysql password: $MYSQL_PASSWORD"
echo "Docker image name: $DOCKER_IMAGE_NAME"
echo "Docker port exposed: $DOCKER_PORTS_EXPOSED"
echo "Host shared folder with container : $HOST_SHARED_FOLDER"