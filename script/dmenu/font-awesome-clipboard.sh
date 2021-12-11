#!/bin/sh


TABLE="$SCRIPT_HOME/dmenu/data/font-awesome/seq.txt"

dmenu < $TABLE | cut -d' ' -f1 | xclip -i -sel clip
