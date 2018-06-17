#!/bin/bash



sudo cp -f env /etc/default/environment

sudo cp -rf  scripts/itransformers /usr/lib
sudo cp -f scripts/systemd/services/* /lib/systemd/system
sudo cp -f scripts/systemd/config/* /etc/default

sudo /usr/lib/itransformers/set_gw_id.sh

sudo curl -sSL https://get.docker.com | sh




sudo systemctl enable ttn-gw
sudo systemctl enable ssh-tunnel@nbu1
sudo shutdown -r now
