if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for script in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$script" ] && . "$script"
  done
  unset script
fi

# Temporarily fix keyd bug (https://github.com/rvaiya/keyd/issues/441)
#   remap Caps-E to primary (left) click,
#   remap Caps-W to secondary (right) click,
#   remap Caps-Q to middle click,
xinput --set-button-map 'keyd virtual pointer' 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 3 2

setxkbmap -option compose:ralt &
pulseaudio-equalizer enable &
ibus-daemon --xim &
picom &
redshift &
monitors &
exec /usr/bin/awesome

# vi: sw=2 sts=2 ts=2 et ft=sh
