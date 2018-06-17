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


cat  << EOF >> env
 RPI_TTN_DOCKER_IMAGE="itransformers/rpi-ttn-gateway:latest"
 LATITUDE=$LATITUDE;
 LONGITUDE=$LONGITUDE;
 ALTITUDE=$ALTITUDE;
 EMAIL="info@itransformers.net";
 REGION="EU";
 LOG="/var/log/itransformers.log";
EOF

cat env

ssh-copy-id -p $SSH_PORT $SSH_USER@$SSH_HOST

if [ -z $7 ]; then
 ssh -p $SSH_PORT $SSH_USER@$SSH_HOST 'sudo apt-get update -y && sudo apt-get install git'
fi
ssh -p $SSH_PORT $SSH_USER@$SSH_HOST 'if [ -r ~/gos ] ; then echo "GOS exists"; cd gos; git pull ; else  git clone https://github.com/iTransformers/gos; fi'

 scp -P $SSH_PORT ttn-rpi $SSH_USER@$SSH_HOST:/tmp/ttn-rpi

#; then echo "Can't copy ssh key "; exit 11 fi;
 ssh -p $SSH_PORT $SSH_USER@$SSH_HOST "sudo mv /tmp/ttn-rpi /root/.ssh/ttn-rpi"
 #; then echo "Can't move ssh key"; exit 12; fi;
 ssh -p $SSH_PORT $SSH_USER@$SSH_HOST "sudo chmod 600 /root/.ssh/ttn-rpi"
 #; then echo "Can't change permissions to ssh key"; exit 13; fi



scp -P $SSH_PORT env $SSH_USER@$SSH_HOST:gos/env;
#then echo "Can't copy env file"; exit 14;  fi
ssh -p $SSH_PORT $SSH_USER@$SSH_HOST 'cd gos; ./install.sh';
#then echo "Installation failed"; exit 15;

echo "Installation sucesfull"
exit 0
