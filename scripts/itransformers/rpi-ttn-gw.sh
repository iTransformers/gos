#!/bin/bash

RPI_TTN_GW_DOCKER_NAME="rpi-ttn-gateway-$GW_ID";

RPI_TTN_DOCKER_IMAGE="itransformers/rpi-ttn-gateway:latest"


LOG="/var/log/itransformers.log";


yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }
run(){

 if [[ $(docker ps -a | grep $RPI_TTN_GW_DOCKER_NAME) ]]; then
     echo "Container with name $RPI_TTN_GW_DOCKER_NAME already exists";
     if [[ $(docker pull $RPI_TTN_DOCKER_IMAGE | grep "Status: Image is up to date") ]]; then
	 echo "$RPI_TTN_DOCKER_IMAGE is up to date exiting"
         exit 0;
     fi
     echo "Current image is not up to date! Cleaning up and will recreate the container";
     try docker stop $RPI_TTN_GW_DOCKER_NAME
     try docker ps -a | awk '{ print $1,$2 }' | grep $RPI_TTN_DOCKER_IMAGE | awk '{print $1 }' | xargs -I {} docker rm {}
     try docker run -d --privileged --net=host --log-opt max-size=50m --restart=always -e PI_RESET_PIN=17 -e GATEWAY_REGION=$REGION -e GATEWAY_EUI=$GW_ID -e GATEWAY_LAT=$LATITUDE -e GATEWAY_LON=$LONGITUDE -e GATEWAY_ALT=$ALTITUDE -e GATEWAY_EMAIL=$EMAIL -e GATEWAY_NAME=$GW_ID --name $RPI_TTN_GW_DOCKER_NAME $RPI_TTN_DOCKER_IMAGE
 else
    echo "Docker container with $RPI_TTN_GW_DOCKER_NAME does not exist";
    try docker pull $RPI_TTN_DOCKER_IMAGE
    try docker run -d --privileged --net=host --log-opt max-size=50m --restart=always -e PI_RESET_PIN=17 -e GATEWAY_REGION=$REGION -e GATEWAY_EUI=$GW_ID -e GATEWAY_LAT=$LATITUDE -e GATEWAY_LON=$LONGITUDE -e GATEWAY_ALT=$ALTITUDE -e GATEWAY_EMAIL=$EMAIL -e GATEWAY_NAME=$GW_ID --name $RPI_TTN_GW_DOCKER_NAME $RPI_TTN_DOCKER_IMAGE
 fi
}

run

