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

BAT_ICO_1=''; BAT_THR_1=20
BAT_ICO_2=''; BAT_THR_2=40
BAT_ICO_3=''; BAT_THR_3=60
BAT_ICO_4=''; BAT_THR_4=80
BAT_ICO_5=''; BAT_THR_5=100

DEV='/sys/class/power_supply/BAT0'
CAP=$(cat "$DEV/capacity")
STAT=$(cat "$DEV/status")

BAT_CLR=$CLR_WHT
BAT_ICO=$BAT_ICO_5
[ $CAP -le $BAT_THR_4 ] && BAT_ICO=$BAT_ICO_4
[ $CAP -le $BAT_THR_3 ] && BAT_ICO=$BAT_ICO_3
[ $CAP -le $BAT_THR_2 ] && BAT_ICO=$BAT_ICO_2
[ $CAP -le $BAT_THR_1 ] && BAT_ICO=$BAT_ICO_1 && BAT_CLR=$CLR_RED

[ $STAT = 'Charging' ] && BAT_CLR=$CLR_GRN

$PRINTF "$BAT_CLR$BAT_ICO %s%%$CLR_STD" "$CAP"
