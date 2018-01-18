#!/bin/bash 

envFile=/etc/environment
NEW_GW_ID=$(cat /sys/class/net/eth0/address | awk -F\: '{print $1$2$3"fffe"$4$5$6}') || true
sed -i '/GW_ID/d' $envFile
echo "GW_ID=$NEW_GW_ID" >> $envFile
