#!/bin/sh

DEV='/sys/class/backlight/intel_backlight'

MIN=75
MAX=$(cat "$DEV/max_brightness")
NOW=$(cat "$DEV/brightness")
UNIT=$(( MAX / 100 ))
[ $UNIT -le 0 ] && UNIT=1

SCALE=${1:-5}
AMOUNT=$(( UNIT * SCALE ))
TARGET=$(( NOW + AMOUNT ))
[ $TARGET -lt $MIN ] && TARGET=$MIN
[ $TARGET -gt $MAX ] && TARGET=$MAX

echo $TARGET > "$DEV/brightness"

# update dwmblocks if active
SIG_BRIGHTNESS=3

pidof dwmblocks 1>/dev/null && sigdwmblocks "$SIG_BRIGHTNESS"
