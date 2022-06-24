#!/bin/sh

MIC_ON=''
MIC_MUTE=''

VOLUME=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk '
	/^Volume/ {
		print(($5 + $12) / 2);
	}
')

MUTE=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '
	/^Mute/ {
		print($2);
	}
')

[ $MUTE = 'yes' ] && VOLUME=0 && MIC_ICO=$MIC_MUTE || MIC_ICO=$MIC_ON

$PRINTF "$DWM_CLR_WHT$MIC_ICO %d%%$DWN_CLR_STD" "$VOLUME"
