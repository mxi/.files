#!/bin/sh


TABLE="$SCRIPT_HOME/dmenu/data/font-awesome/seq.txt"

dmenu < $TABLE | cut -d' ' -f1 | tr -d '\n' | xclip -i -sel clip
