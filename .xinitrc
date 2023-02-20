if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for script in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$script" ] && . "$script"
  done
  unset script
fi

setxkbmap -option compose:ralt &
pulseaudio-equalizer enable &
ibus-daemon --xim &
picom &
redshift &
monitors &
exec /usr/bin/awesome

# vi: sw=2 sts=2 ts=2 et ft=sh
