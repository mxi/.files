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

$PRINTF "$CLR_WHT$MIC_ICO %d%%$CLR_STD" "$VOLUME"
