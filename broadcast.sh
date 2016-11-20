#!/bin/bash

INTERVAL=15
IFACE=wlan0
SSIDPATH=/tmp/bitcoin-ssid-ticker.txt

iw dev $IFACE interface add mon0 type monitor && ifconfig mon0 up

echo . > $SSIDPATH
mdk3 mon0 b -s 500 -m -a -c 11 -h -f $SSIDPATH &

while :
do
  echo "Updating bitcoin ticker..."
  data=$(./ticker.sh)
  data=(${data//$'\n'/ })
  cat ssid.txt | sed "s/%P/${data[0]}/g" | sed "s/%C/${data[1]}/g" | tee $SSIDPATH
  # mdk3 auto-updates when we change the file, no need to restart
  sleep $INTERVAL
done
