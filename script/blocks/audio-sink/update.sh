#!/bin/sh

# GNU printf full path because dash
# doesn't have one built-in.
PRINTF='/usr/bin/printf'

# Color schemes are byte characters that
# index into the dwm colors array. By some
# technicality, the first element is located
# on 0x0b.
#
# The color variable names are associated as
# they are defined in my dwm config.h
CLR_STD='\x0b'
CLR_WHT='\x0c'
CLR_RED='\x0d'
CLR_GRN='\x0e'
CLR_BLU='\x0f'

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

$PRINTF "$CLR_WHT$VOL_ICO %d%%$CLR_STD" "$VOLUME"
