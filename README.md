# bitcoin-ssid-ticker

#### Real time price ticker for Bitcoin over wifi network names (SSID)

Price pulled from [BitcoinAverage](https://bitcoinaverage.com/) and broadcasted using [mdk3](http://tools.kali.org/wireless-attacks/mdk3).
Script written for Openwrt, but likely to work elsewhere. Ideal for a [portable router](https://wiki.openwrt.org/toh/tp-link/tl-mr3040),
send over-the-air bitcoin graffiti anywhere you go!

### How it looks

![example](https://github.com/shesek/bitcoin-ssid-ticker/raw/master/example.png)

![example](https://github.com/shesek/bitcoin-ssid-ticker/raw/master/example2.png)

### How it works

This uses [mdk3](http://tools.kali.org/wireless-attacks/mdk3) to transmit raw [beacon management frames](https://en.wikipedia.org/wiki/Beacon_frame)
identifying as wifi access points with custom SSIDs. These APs don't really exists and can't be connected to.

### Dependencies (openwrt):

    opkg install bash http://downloads.openwrt.org/barrier_breaker/14.07/ar71xx/generic/packages/oldpackages/mdk3_v6-2_ar71xx.ipk

### Scripts:

- `./ticker.sh`: fetches data from bitcoinaverage and outputs `[price] [24_hour_change]`

- `./broadcast.sh`: starts mdk3 and periodically updates the ticker data (by default, every 15s)

### Configuration:

The network names are configured in [`ssid.txt`](https://github.com/shesek/bitcoin-ssid-ticker/blob/master/ssid.txt), one SSID per line.
`%P` is replaced with current (rounded) price, `%C` is replaced with the 24h price change.
Network names are limited to 32 bytes.

Some more configuration options are available in `broadcast.sh`:

- `INTERVAL` - interval for pulling data from BitcoinAverage, in seconds.

    default: 15 seconds

- `IFACE` - the network interface to use (monitor mode should be supported and will automatically be activated)

    default: wlan0

- `SSIDPATH` - temporary file to write network names to.

    defailt: /tmp/bitcoin-ssid-ticker.txt

