#!/bin/sh


xwd -root | convert xwd:- png:- | xclip -i -sel clip
