#!/bin/sh

DEV='/sys/class/backlight/intel_backlight'

MIN=50
MAX=$(cat "$DEV/max_brightness")
NOW=$(cat "$DEV/brightness")
UNIT=$(( MAX / 100 ))
[ $UNIT -le 0 ] && UNIT=1

PERCENT=${1:-25}
TARGET=$(( UNIT * PERCENT ))
[ $TARGET -lt $MIN ] && TARGET=$MIN
[ $TARGET -gt $MAX ] && TARGET=$MAX

echo $TARGET > "$DEV/brightness"
