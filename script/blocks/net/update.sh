#!/bin/sh

COLOR=$DWM_CLR_WHT
NETINFO=$(nmcli -t c s --active | awk -v FS=':' '
	BEGIN {
		VPN  = "";
		TUN  = "";
		CONN = "";
	}

	$3 == "vpn" {
		VPN = $1;
	}
	
	$3 == "tun" {
		TUN = $1;
	}

	$3 != "vpn" && $3 != "tun" {
		CONN = $1;
	}

	END {
		print VPN ":" TUN ":" CONN;
	}
')

VPN=$(echo "$NETINFO" | cut -d: -f1)
TUN=$(echo "$NETINFO" | cut -d: -f2)
CONN=$(echo "$NETINFO" | cut -d: -f3)

if [ -z "$CONN" ]; then
	$PRINTF "$DWM_CLR_RED %s$DWM_CLR_STD" "ECONN"
elif [ -z "$VPN" ]; then
	$PRINTF "$DWM_CLR_WHT %s$DWM_CLR_STD" "$CONN"
else
	$PRINTF "$DWM_CLR_WHT %s$DWM_CLR_STD/$DWM_CLR_BLU%s$DWM_CLR_STD" "$CONN" "$VPN"
fi
