#!/bin/sh

DEV='/sys/class/backlight/intel_backlight'
FILE="$DEV/brightness"
SIG_BRIGHTNESS=3

inotifywait -e modify -m "$FILE" |
	while IFS='' read -r x; do
		sigdwmblocks $SIG_BRIGHTNESS
	done
