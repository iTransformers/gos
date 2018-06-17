#!/bin/bash

SSH_HOST=$1

SSH_PORT=$2

SSH_USER=$3


ssh -p $SSH_PORT pi@$SSH_HOST 'sudo apt-get update -y && sudo apt-get install git'

ssh -p $SSH_PORT pi@$SSH_HOST 'git clone https://github.com/iTransformers/gos'

scp -p $SSH_PORT env pi@$SSH_HOST:gos/env

ssh -p $SSH_PORT pi@$SSH_HOST 'cd gos; ./install.sh'
