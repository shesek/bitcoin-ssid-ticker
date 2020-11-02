#!/bin/bash
url='https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd&include_24hr_change=true'
data=$(wget -qO- $url|./JSON.sh)
price=$(echo "$data"|grep '"usd"]'|cut -d$'\t' -f2|sed -r 's/\..*//')
change=$(echo "$data"|grep '"usd_24h_change"]'|cut -d$'\t' -f2|sed -r 's/\..*//'|sed 's/^-/-$/'|sed -r 's/^[0-9]/+$\0/')

echo "\$$price $change"
