#!/bin/sh

USAGE=$(free | awk '
	/^Mem/ {
		print(sprintf("%.0f%%",100-100*$7/$2));
	}
')

$PRINTF "$DWM_CLR_WHT %s$DWM_CLR_STD" "$USAGE"
