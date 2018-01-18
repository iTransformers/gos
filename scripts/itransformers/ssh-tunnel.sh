#!/bin/bash 

unit=$1
CPU_SERIAL=`cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2`
sleep 5;
TUNNEL_OUTPUT=`journalctl -u $unit --since "1 min ago"| grep "Allocated port"| tail -n 1`;
regex='Allocated port[[:space:]]([0-9]{5}|[0-9]{4}|[0-9]{3})';
if [[ $TUNNEL_OUTPUT =~ $regex ]]; then
       port=${BASH_REMATCH[1]};
else
       echo "Failed in getting tunnel output port"
       exit 1
fi

echo "DATE=`date '+%Y%m%d%H%M%S'`,CPU_SERIAL=${CPU_SERIAL}, GW_ID=${GW_ID},TUNNEL_OUTPUT=${port}" > /tmp/gwinfo

echo "/usr/bin/ssh -i ${KEY_PATH} -p ${TARGET_PORT} ${USER}@${TARGET} mkdir -p gwids"

/usr/bin/ssh -i ${KEY_PATH} -p ${TARGET_PORT} ${USER}@${TARGET} mkdir -p gwids
/usr/bin/scp -i ${KEY_PATH} -P ${TARGET_PORT} /tmp/gwinfo ${USER}@${TARGET}:gwids/${GW_ID}
