#!/bin/sh


TABLE="$SCRIPT_HOME/dmenu/data/unicode/d.all.tsv"

dmenu -l 10 < $TABLE | cut -d' ' -f1 | xclip -i -sel clip
