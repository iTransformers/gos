#!/bin/bash

SSH_HOST=$1

SSH_PORT=$2

SSH_USER=$3

LONGITUDE=$4
LATITUDE=$5
ALTITUDE=$6
if [ -z "$LONGITUDE" ]; then
 read -p "Enter Longitude: " LONGITUDE
fi
if [ -z "$LATITUDE" ]; then
read -p "Enter Latitude: " LATITUDE
fi
if [ -z "$ALTITUDE" ]; then
read -p "Enter Altitude: " ALTITUDE
fi
echo


echo << EOF > env
RPI_TTN_DOCKER_IMAGE="itransformers/rpi-ttn-gateway:latest"
LATITUDE=$LATITUDE;
LONGITUDE=$LONGITUDE;
ALTITUDE=$ALTITUDE;
EMAIL="info@itransformers.net";
REGION="EU";
LOG="/var/log/itransformers.log";
EOF

ssh-copy-id -p $SSH_PORT $SSH_USER@$SSH_HOST

if [ -z $7 ]; then
 ssh -p $SSH_PORT $SSH_USER@$SSH_HOST 'sudo apt-get update -y && sudo apt-get install git'
fi
ssh -p $SSH_PORT $SSH_USER@$SSH_HOST 'if [ -r ~/gos ]; then echo "GOS exists"; cd gos;git pull ; else  git clone https://github.com/iTransformers/gos; fi'

scp -P $SSH_PORT ttn-rpi $SSH_USER@$SSH_HOST /tmp/ttn-rpi
ssh -p $SSH_PORT $SSH_USER@$SSH_HOST sudo mv /tmp/ttn-rpi /root/.ssh/ttn-rpi
ssh -p $SSH_PORT $SSH_USER@$SSH_HOST sudo chmod 600 /root/.ssh/ttn-rpi



scp -P $SSH_PORT env $SSH_USER@$SSH_HOST:gos/env

ssh -p $SSH_PORT $SSH_USER@$SSH_HOST 'cd gos; ./install.sh'
