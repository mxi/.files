#!/bin/sh

OUTPUT="$SCREENSHOT_DIR/$(date +'%Y%m%d-%H%M%S').png"
/usr/bin/maim -B -u -s -l --color='0.75,0.50,0.25,0.25' "$OUTPUT" && \
	/usr/bin/xclip -i -sel clip < "$OUTPUT"
