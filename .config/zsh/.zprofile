# env: xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache" 
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="$HOME/.local/run"

# env: paths & programs
IPATH="$PATH"
IPATH="$HOME/.local/bin:$IPATH"
IPATH="$HOME/script/dmenu:$IPATH"
IPATH="$HOME/script/exe:$IPATH"

export PATH="$IPATH"
export PYTHONPATH="$PYTHONPATH:$HOME/code/py/"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

export EDITOR='/usr/bin/nvim'
export MANPAGER='/usr/bin/nvim +"Man!" -o -'
export PDFVIEW='/usr/bin/zathura'
export BROWSER='/usr/bin/firefox'
export TERMINAL='/usr/local/bin/st'
export PRINTF='/usr/bin/printf'
export KILL='/usr/bin/kill'

# env: re-route to CONFIG
export XAUTHORITY="$XDG_DATA_HOME/X/Xauthority"
export XCOMPOSEFILE="$XDG_CONFIG_HOME/X/XCompose"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# env: re-route to CACHE
export LESSHISTFILE="$XDG_CACHE_HOME/lesshist"
export CARGO_HOME="$HOME/.cache/cargo"

# env: re-route to DATA
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"

# env: other routes
export WALLPAPERS_DIR="$HOME/doc/images/wallpapers/"
export SCREENSHOT_DIR="$HOME/doc/images/screenshots/"
export EDUCATION_HOME="$HOME/doc/edu/"
export SCRIPT_HOME="$HOME/script"

# dwm colors
export DWM_CLR_STD='\x0b'
export DWM_CLR_WHT='\x0c'
export DWM_CLR_RED='\x0d'
export DWM_CLR_GRN='\x0e'
export DWM_CLR_BLU='\x0f'

# nnn
export NNN_COLORS="#fffcf9f6"

# launch:
# systemd userspace doesn't seem to properly start the pulse audio 
# daemon since the status says active (running) but pulseaudio --check 
# -v says no daemon is running. For the time being I'll just start it 
# manually here.
pulseaudio --check -v || pulseaudio --daemonize

# NetworkManager sucks
sudo systemctl restart NetworkManager

# start xserver
startx
