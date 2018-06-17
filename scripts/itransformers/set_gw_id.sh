#!/bin/bash

envFile=/etc/environment
GW_ID=$(cat /sys/class/net/eth0/address | awk -F\: '{print $1$2$3"fffe"$4$5$6}') || true
sed -i '/GW_ID/d' $envFile
echo "Setting GW_ID to: $GW_ID"
echo "GW_ID=$GW_ID" >> $envFile


add() {
hostname=$1
ip=$2

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }
hostsFile=/etc/hosts
    if [ -n "$(grep -P "[[:space:]]$hostname" /etc/hosts)" ]; then
        yell "$hostname, already exists: $(grep $hostname $hostsFile)";
    else
        echo "Adding $hostname to $hostsFile...";
        try printf "%s\t%s\n" "$ip" "$hostname" | sudo tee -a "$hostsFile" > /dev/null;

        if [ -n "$(grep $hostname /etc/hosts)" ]; then
            echo "$hostname was added succesfully:";
            echo "$(grep $hostname /etc/hosts)";
        else
            die "Failed to add $hostname";
        fi
    fi
}

if [ ! -f /etc/hostname ]; then
    echo $GW_ID > /etc/hostname
    /bin/hostname -F /etc/hostname
    add $GW_ID 127.0.1.1
elif [ "$GW_ID" != `cat /etc/hostname` ]; then
    echo $GW_ID > /etc/hostname
    /bin/hostname -F /etc/hostname
    add $GW_ID 127.0.1.1
else
   echo "Hostname already set to $GW_ID";
fi

