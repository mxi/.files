#!/bin/sh

BAT_ICO_1=''; BAT_THR_1=20
BAT_ICO_2=''; BAT_THR_2=40
BAT_ICO_3=''; BAT_THR_3=60
BAT_ICO_4=''; BAT_THR_4=80
BAT_ICO_5=''; BAT_THR_5=100

DEV='/sys/class/power_supply/BAT0'
CAP=$(cat "$DEV/capacity")
STAT=$(cat "$DEV/status")

BAT_CLR=$DWM_CLR_WHT
BAT_ICO=$BAT_ICO_5
[ $CAP -le $BAT_THR_4 ] && BAT_ICO=$BAT_ICO_4
[ $CAP -le $BAT_THR_3 ] && BAT_ICO=$BAT_ICO_3
[ $CAP -le $BAT_THR_2 ] && BAT_ICO=$BAT_ICO_2
[ $CAP -le $BAT_THR_1 ] && BAT_ICO=$BAT_ICO_1 && BAT_CLR=$DWM_CLR_RED

[ $STAT = 'Charging' ] && BAT_CLR=$DWM_CLR_GRN

$PRINTF "$BAT_CLR$BAT_ICO %s%%$DWM_CLR_STD" "$CAP"
