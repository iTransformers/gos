#!/bin/bash



sudo cp -f env /etc/default/environment
sudo cp -rf  scripts/itransformers /usr/lib
sudo cp -f scripts/systemd/services/* /lib/systemd/system

sudo /usr/lib/itransformers/set_gw_id.sh

if ! systemctl is-active --quiet docker; then  sudo curl -sSL https://get.docker.com| sh; sudo usermod -aG docker pi; fi
sudo systemctl enable ssh-tunnel@nbu1
sudo systemctl enable ttn-gw
sudo systemctl enable first-boot
sudo systemctl daemon-reload

sudo systemctl start first-boot
sudo systemctl start ssh-tunnel@nbu1
sudo systemctl start ttn-gw

sudo shutdown -r now
