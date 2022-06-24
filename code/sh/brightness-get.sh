#!/bin/sh

DEV='/sys/class/backlight/intel_backlight'
MAX=$(cat "$DEV/max_brightness")
NOW=$(cat "$DEV/brightness")
PERCENT=$(( 100 * NOW / MAX ))

echo "$PERCENT"
