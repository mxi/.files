# mostly defaults, but here just in case
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_DIRS=(
  "$HOME/.local/share/flatpak/exports/share:"
  "/var/lib/flatpak/exports/share:"
  "/usr/local/share:"
  "/usr/share:"
)
export XDG_CONFIG_DIRS="/etc/xdg"

. "$XDG_CONFIG_HOME/zsh/.zprofile_private"

# paths
export PATH="$HOME/.local/bin:$PATH"
export PYTHONHISTORY="$XDG_CACHE_HOME/.python_history"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

# programs
export EDITOR="$(which nvim)"
export TERMINAL="$(which alacritty)"
export MANPAGER="$EDITOR +'Man!' -o -"

# home cleanup
export XCOMPOSEFILE="$XDG_CONFIG_HOME/XCompose/main"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export LESSHISTFILE="$XDG_DATA_HOME/lesshist"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# dwm colors
export DWM_CLR_STD='\x0b'
export DWM_CLR_WHT='\x0c'
export DWM_CLR_RED='\x0d'
export DWM_CLR_GRN='\x0e'
export DWM_CLR_BLU='\x0f'

# alacritty
export WINIT_X11_SCALE_FACTOR=1

# nnn
export NNN_COLORS="#fffcf9f6"
export NNN_PLUG='1:-!&xournalpp $nnn;'
eval $(dircolors >&/dev/null -b)

# neovide
export NEOVIM_BIN="$EDITOR"

# ssh
eval $(ssh-agent >&/dev/null -s)

# manual xorg
if ! pidof >&/dev/null Xorg; then
  # we can't set it outside because it breaks login managers (obviously)
  export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
  # sleep in case we screw up config
  sleep 0.5
  startx
fi

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
