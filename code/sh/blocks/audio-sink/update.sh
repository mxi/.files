#!/bin/sh

VOL_ICO_MUTE=''
VOL_ICO_LOW='';  VOL_THR_LOW=16
VOL_ICO_MED='';  VOL_THR_MED=33
VOL_ICO_HI='';   VOL_THR_HI=50

VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '
	/^Volume/ {
		print(($5 + $12) / 2);
	}
')

MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '
	/^Mute/ {
		print($2);
	}
')

VOL_ICO=$VOL_ICO_HI
[ $VOLUME -le $VOL_THR_MED ] && VOL_ICO=$VOL_ICO_MED
[ $VOLUME -le $VOL_THR_LOW ] && VOL_ICO=$VOL_ICO_LOW
[ $MUTE = 'yes' ] && VOL_ICO=$VOL_ICO_MUTE && VOLUME=0

$PRINTF "$DWM_CLR_WHT$VOL_ICO %d%%$DWM_CLR_STD" "$VOLUME"
