# functionality
setxkbmap -option compose:ralt

# looks and stuff
xset s 120
picom &
dwmblocks &
# feh --no-fehbg -z --bg-fill "$HOME/doc/images/wallpapers/target/"
feh --no-fehbg -z --bg-scale "$HOME/doc/images/wallpapers/hahayes.png"

# daemons
dunst &
redshift &
pulseaudio-daemon.sh &
# brightness-daemon.sh &
xss-daemon.sh slock &

# wm
exec dwm
