#!/bin/sh


DURATION=${1:-5}
OUTPUT=${2:-clip}
OUTPUT="$OUTPUT.mp4"
echo "Preparing to capture $OUTPUT for $DURATION seconds."

# Using DATA is a pretty dumb fix for dash not supporting 
# `read`, which should be part of the POSIX standard 
# anyways :shrug:
echo "Click on desired window to capture."
DATA=$(xwininfo | awk '
	BEGIN {
		X = -1;
		Y = -1;
		WIDTH = -1;
		HEIGHT = -1;
	}

	/Absolute.*X:/ {
		X = $4;
	}
	/Absolute.*Y:/ {
		Y = $4;
	}
	/Width:/ {
		WIDTH = $2;
	}
	/Height:/ {
		HEIGHT = $2;
	}

	END {
		print(X " " Y " " WIDTH " " HEIGHT);
	}
')
X=$(echo $DATA | cut -d' ' -f1)
Y=$(echo $DATA | cut -d' ' -f2)
W=$(echo $DATA | cut -d' ' -f3)
H=$(echo $DATA | cut -d' ' -f4)


ffmpeg                        \
	-y                        \
	-f x11grab                \
	-framerate 50             \
	-t $DURATION              \
	-s ${W}x${H}              \
	-i :0.0+$X,$Y             \
	$OUTPUT
