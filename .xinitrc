# functionality
setxkbmap -option compose:ralt

# looks and stuff
xset s 3600
picom &
dwmblocks &
wallp default

# daemons
dunst &
redshift &
pulseaudio-daemon.sh &
xss-daemon.sh slock &

# wm
exec dwm
