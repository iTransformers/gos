#!/bin/bash


echo "Cleanup hosts file"
sudo sed -i~ -e /^127.0.1.1/d /etc/hosts

echo "Cleanup hostname"

sudo rm /etc/hostname


echo "Cleanup docker" 
docker rm -f rpi-ttn-gateway-$GW_ID


echo "Cleanup history"

rm /home/pi/.bash_history
sudo rm /root/.bash_history 

echo "Cleanup logs"
sudo rm /var/log/*.log
sudo find /var/log/ -type f -regex '.*\.[0-9]$' -delete
sudo find /var/log/ -type f -regex '.*\.gz$' -delete
