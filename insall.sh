#!/bin/bash

sudo cp -r  scripts/itransformers /usr/lib
sudo cp scripts/systemd/services/* /lib/systemd/system
sudo scripts/systemd/config/* /etc/default
