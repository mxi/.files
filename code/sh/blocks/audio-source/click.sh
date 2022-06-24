#!/bin/sh

case "$1" in 
	1) pactl set-source-mute @DEFAULT_SOURCE@ toggle ;;
	3) pactl set-source-volume @DEFAULT_SOURCE@ 25% ;;
esac
