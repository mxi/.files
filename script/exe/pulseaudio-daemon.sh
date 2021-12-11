#!/bin/sh

# Start with .xinitrc that starts dwm+dwmblocks
# to send signals on audio changes. Set `SIG_SINK` 
# and `SIG_SOURCE` according to the signal values
# your dwmblocks config.h

SINK_SIG=6
SRC_SIG=7

pactl subscribe | 
	while IFS='' read -r x; do
		case "$x" in
			*" sink "*) sigdwmblocks "$SINK_SIG" ;;
			*" source "*) sigdwmblocks "$SRC_SIG" ;;
		esac
	done
