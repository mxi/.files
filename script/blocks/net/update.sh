#!/bin/sh

COLOR=$DWM_CLR_WHT
NAME=$(nmcli c s --active | awk '
	$1 != "NAME" {
		print $1;
	}
')
[ -z "$NAME" ] && NAME="No Connection" && COLOR=$DWM_CLR_RED


$PRINTF "$COLOR %s$DWM_CLR_STD" "$NAME"

