#!/bin/bash



sudo cp -f env /etc/default/environment
sudo cp -rf  scripts/itransformers /usr/lib
sudo cp -f scripts/systemd/services/* /lib/systemd/system

sudo /usr/lib/itransformers/set_gw_id.sh

sudo curl -sSL https://get.docker.com | sh

sudo usermod -aG docker pi
sudo cp -f ttn-rpi /root/.ssh/ttn-rpi
sudo chmod 600 /root/.ssh/ttn-rpi

sudo systemctl enable ssh-tunnel@nbu1
sudo systemctl enable ttn-gw
sudo systemctl daemon-reload

sudo systemctl start ssh-tunnel@nbu1
sudo systemctl start ttn-gw

sudo shutdown -r now
