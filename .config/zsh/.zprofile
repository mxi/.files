print_error() {
  [ -t 1 ] && echo -e "\033[31m${*}\033[0m"
}

# xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_DIRS="/etc/xdg"
xdg_data_dirs=(
  "$HOME/.local/share/flatpak/exports/share"
  "/var/lib/flatpak/exports/share"
  "/usr/local/share"
  "/usr/share"
)
export XDG_DATA_DIRS="${(j|:|)xdg_data_dirs}"

# paths
path=(
  "$HOME/.local/bin/"
  "$PATH"
)
export PATH="${(j|:|)path}"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

# programs
EDITOR="$(which nvim)" && export EDITOR || {
  print_error "EDITOR: nvim not found."
  unset EDITOR
}
TERMINAL="$(which alacritty)" && export TERMINAL || {
  print_error "TERMINAL: alacritty not found."
  unset TERMINAL
}
PAGER="$(which less)" && export PAGER || {
  print_error "PAGER: less not found (???)."
  unset PAGER
}

if [[ "$EDITOR" == *nvim ]] && [[ "$($EDITOR --version | head -n 1)" < "NVIM v0.7.3" ]]; then
  export MANPAGER="$EDITOR +'Man!' -o -"
fi

# home cleanup
export PYTHONHISTORY="$XDG_CACHE_HOME/.python_history"
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

# ls
eval $(dircolors >&/dev/null -b)

# ssh
export SSH_AUTH_SOCK="$HOME/.ssh/sock"
SSH_AGENT_PID="$(pidof ssh-agent)" && export SSH_AGENT_PID || {
  ssh-agent >&/dev/null -a "$SSH_AUTH_SOCK" && \
    export SSH_AGENT_PID="$(pidof ssh-agent)"
}

# alacritty
export WINIT_X11_SCALE_FACTOR=1

# nnn
export NNN_COLORS="#fffcf9f6"
export NNN_PLUG='1:-!&xournalpp $nnn;'

# neovide
export NEOVIM_BIN="$EDITOR"

. "$XDG_CONFIG_HOME/zsh/.zprofile_private"

# X
pidof >&/dev/null Xorg || {
  # we can't set it outside because it breaks login managers (obviously)
  export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
  # sleep in case we screw up config
  sleep 0.5
  startx
}

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
