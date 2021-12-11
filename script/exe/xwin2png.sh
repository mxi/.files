#!/bin/sh


xwd | convert xwd:- png:- | xclip -i -sel clip
