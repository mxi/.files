#!/bin/sh
#
# 2023-04-01: I've since moved to KDE because I'm tired of wasting time. 
# This is mostly a historic relic now.
#
# NOTE: we assume we're running the intel driver because the names of the
#       ports change with different drivers. Further, some drivers freeze
#       for a bit on $(xrandr) making the computer unusable when this is
#       called from udev events.
#
info=$(xrandr)

if echo $info | grep >/dev/null "HDMI1 connected"; then
  if ! echo $info | grep >/dev/null "HDMI1 connected primary"; then
    xrandr --output HDMI1 --primary --auto --mode 1920x1080 --scale-from 1920x1200 \
           --output eDP1 --off
  fi
else
  xrandr --output eDP1 --primary --auto --mode 1920x1080 \
         --output HDMI1 --off
fi

# vi: sw=2 ts=2 sts=2 et
