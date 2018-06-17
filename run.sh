#!/bin/bash

SSH_HOST=$1

SSH_PORT=$2

SSH_USER=$3


ssh-copy-id -p $SSH_PORT $SSH_USER@$SSH_HOST

ssh -p $SSH_PORT $SSH_USER@$SSH_HOST 'sudo apt-get update -y && sudo apt-get install git'

ssh -p $SSH_PORT $SSH_USER@$SSH_HOST 'if [ -r ~/gos ]; then echo "GOS exists moving it to gos_bak";  mv gos gos_bak; fi'


ssh -p $SSH_PORT $SSH_USER@$SSH_HOST 'git clone https://github.com/iTransformers/gos'

scp -P $SSH_PORT env $SSH_USER@$SSH_HOST:gos/env

ssh -p $SSH_PORT $SSH_USER@$SSH_HOST 'cd gos; ./install.sh'
