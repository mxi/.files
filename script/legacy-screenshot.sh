#!/bin/sh
#
# 2023-04-01: I've since moved to KDE because I'm tired of wasting time. 
# This is mostly a historic relic now.
#
OUTPUT="$HOME/image/screenshot/$(date +'%Y%m%d-%H%M%S').png"

/usr/bin/maim -B -u -l $@ --color='0.75,0.50,0.25,0.25' "$OUTPUT" && \
	/usr/bin/xclip -i -sel clip < "$OUTPUT"
