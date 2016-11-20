#!/bin/bash

data=$(wget -qO- https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD|./JSON.sh|egrep '\["last"\]|\["changes","price","day"\]'|cut -d$'\t' -f2)
data=(${data//$'\n'/ })
price="\$$(echo ${data[0]}|sed -r 's/\n|\..*//g')"
change=$(echo ${data[1]}|sed 's/\n//'|sed 's/^-/-$/'|sed -r 's/^[0-9]/+$\0/')

echo "$price $change"
