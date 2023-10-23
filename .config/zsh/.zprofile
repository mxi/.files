print_warning() {
  [ -t 1 ] && echo -e "\033[93m${*}\033[0m" || echo "${*}"
}

print_error() {
  [ -t 1 ] && echo -e "\033[91m${*}\033[0m" || echo "${*}"
}

get_pid() {
  if type >&/dev/null pgrep; then
    pgrep -xn "${1:?}"
  elif type >&/dev/null pidof; then
    pidof -s "${1:?}"
  else
    print_error "No process inspection commands (pgrep, pidof) on PATH!"
    exit 1
  fi
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
  "$HOME/script"
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
  print_error "PAGER: less not found (??)."
  unset PAGER
}

if [[ "$EDITOR" = *nvim ]] && [[ "$($EDITOR --version | head -n 1)" < "NVIM v0.7.3" ]]; then
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
export MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# ls
eval $(dircolors -b)

# ssh
SSH_AUTH_SOCK="$HOME/.ssh/sock"
SSH_AGENT_PID="$(get_pid ssh-agent)" || {
  [ -S "$SSH_AUTH_SOCK" ] && {
    print_warning "Removing $SSH_AUTH_SOCK to allow ssh-agent to spawn!"
    rm "$SSH_AUTH_SOCK"
  }
  ssh-agent 1>/dev/null -a "$SSH_AUTH_SOCK" && {
    SSH_AGENT_PID="$(get_pid ssh-agent)"
  }
}
[ -n "$SSH_AGENT_PID" ] && {
  export SSH_AUTH_SOCK
  export SSH_AGENT_PID
}

# alacritty
export WINIT_X11_SCALE_FACTOR=1

# nnn
export NNN_COLORS="#fffcf9f6"
export NNN_PLUG='1:-!&xournalpp $nnn;'

# neovide
export NEOVIM_BIN="$EDITOR"

# finalize
. "$XDG_CONFIG_HOME/zsh/.zprofile_private"

get_pid >&/dev/null Xorg || {
  # we can't set it outside because it breaks login managers (obviously)
  export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
  # sleep in case we screw up config
  sleep 0.5
  startx
}

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
