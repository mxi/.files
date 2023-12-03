export GPG_TTY=$(tty)
export VIRTUAL_ENV_DISABLE_PROMPT=1

setopt glob_dots
setopt extendedglob
setopt promptsubst

unalias run-help >& /dev/null
autoload -U run-help
autoload -U compinit && compinit

. "$ZDOTDIR/util.zsh"
. "$ZDOTDIR/prompt.zsh"

# git
alias dotfiles="git --git-dir=$HOME/.files/ --work-tree=$HOME"
alias gco="git cat-file --batch-check --batch-all-objects"
alias glo="git log --oneline"
alias gs="git status"

# systemd
alias userctl="systemctl --user"
alias journal="journalctl -r"
alias poweroff="systemctl poweroff"
alias suspend="systemctl suspend"
alias reboot="systemctl reboot"
alias logout="loginctl terminate-session ''"

# quicksource / quickedit
alias ealac="$EDITOR $XDG_CONFIG_HOME/alacritty/alacritty.yml"
alias eawesome="$EDITOR $XDG_CONFIG_HOME/awesome/rc.lua"
alias ecompose="$EDITOR $XCOMPOSEFILE"
alias edotmap="$EDITOR $HOME/.local/bin/dotmap"
alias envim="$EDITOR $XDG_CONFIG_HOME/nvim/init.vim"
alias exinit="$EDITOR $HOME/.xinitrc"
alias ezathura="$EDITOR $XDG_CONFIG_HOME/zathura/zathurarc"
alias ezprof="$EDITOR $ZDOTDIR/.zprofile"
alias ezrc="$EDITOR $ZDOTDIR/.zshrc"
alias ezprompt="$EDITOR $ZDOTDIR/.zshrc_prompt"
alias ezetc="$EDITOR $ZDOTDIR/tools/etc.zsh"
alias reprofile="source $ZDOTDIR/.zprofile"
alias resource="source $ZDOTDIR/.zshrc"

# dates
alias day="date +'%Y%m%d'"
alias now="date +'%Y%m%d-%H%M%S'"

# cd
alias cdconf="cd $XDG_CONFIG_HOME"
alias cddoc="cd ~/doc/"
alias cdedu="cd ~/edu/"
alias cdimage="cd ~/image"
alias cdsrc="cd ~/src"
alias cdvideo="cd ~/video"
alias cdvm="cd ~/vm"

# coreutils
alias grep="grep -En --color=auto"
alias ls="ls -vAh --group-directories-first --color=auto"

# singlechars
alias e="$EDITOR"
alias l="ls -l"

# miscellaneous aliases
alias clm="clear && make"
alias cls="clear && l"
alias dasm="objdump -d -M intel"
alias diff="diff -u --color=auto"
alias hexdump="hexdump -C"
alias make="make -j8"
alias man="man -E latin1"
alias mpv="mpv --script-opts=osc-timems=yes"
alias nnn="nnn -de"
alias open="xdg-open"
alias pandoc="pandoc --pdf-engine=xelatex"
alias pdf="zathura >>& /dev/null"
alias xpp="xournalpp >>& /dev/null"

. "$ZDOTDIR/.zshrc_private"

#  _____ _   _ _   _  ____ _____ ___ ___  _   _ ____  
# |  ___| | | | \ | |/ ___|_   _|_ _/ _ \| \ | / ___| 
# | |_  | | | |  \| | |     | |  | | | | |  \| \___ \ 
# |  _| | |_| | |\  | |___  | |  | | |_| | |\  |___) |
# |_|    \___/|_| \_|\____| |_| |___\___/|_| \_|____/ 
#                                                     
ls_path() {
  for d in $(echo "$PATH" | tr ':' '\n'); do
    for f in $(/usr/bin/ls "$d"); do
      echo "$d/$f"
    done
  done
}

ls_gsettings() {
  for schema in $(gsettings list-schemas) $(gsettings list-relocatable-schemas); do
    echo "$schema"
    for key in $(gsettings list-keys $schema); do
      echo "    $key = $(gsettings get $schema $key)"
    done
  done
}

ls_gcc_defines() {
  gcc -E -dM - < /dev/null
}

what_the_commit() {
  curl 2>/dev/null "https://whatthecommit.com/index.txt"
}

concat_media_files() {
  local usage="usage: concat_media_files [audio|video] OUTPUT INPUT..."

  local media_type="$1" && shift >&/dev/null || {
    print_error "$usage"
    return 1
  }
  if [ "$media_type:l" = "video" ]; then
    local video=1
  elif [ "$media_type:l" != "audio" ]; then
    print_error "First argument must either be 'audio' or 'video'."
    return 1
  fi

  local output="$1" && shift >&/dev/null || {
    print_error "$usage"
    return 1
  }

  local inputs=()
  local filter=""
  typeset -i index=0

  for file in "$@"; do
    inputs+=("-i" "$file")
    [ $video -eq 1 ] && {
      filter+="[${index}:v][${index}:a]"
    } || {
      filter+="[${index}:a]"
    }
    index+=1
  done

  local maps

  [ $video -eq 1 ] && {
    filter+="concat=n=${index}:v=1:a=1 [v] [a]"
    maps=(
      "-map" "[v]"
      "-map" "[a]"
    )
  } || {
    filter+="concat=n=${index}:v=0:a=1 [a]"
    maps=(
      "-map" "[a]"
    )
  }

  ffmpeg $inputs -filter_complex "$filter" $maps "$output"
}

set_color_preference() {
  if [ -n "$1" ]; then
    case $1 in
      "light") 
        gsettings set org.gnome.desktop.interface color-scheme prefer-light 
      ;;
      "dark") 
        gsettings set org.gnome.desktop.interface color-scheme prefer-dark
      ;;
      *)
        print_error "Theme must be either 'light' or 'dark' (case sensitive.)"
      ;;
    esac
  else
    print_error "usage: set-color-preference <light|dark>"
  fi
}

copy_screenshots() {
  sxiv -t -o ~/image/screenshot/ | xargs cp -t ${1:-.}
}

delete_nvim_swapfiles() {
  \rm -irf "$HOME/.local/state/nvim/swap/"*
  \rm -irf "$HOME/.local/share/nvim/swap/"*
}

sensitivity() {
  local program="sensitivity"
  local usage="usage: sensitivity [SCALE=1.3 [DEVICE=\$__OPSEC_PRIMARY_MOUSE]]"

  local scale=$1 
  [ -z "${scale:=1.3}" ] && {
    print_error "$usage"
    return 1
  }

  local device=$2 
  [ -z "${device:=$__OPSEC_PRIMARY_MOUSE}" ] && {
    print_error "$usage"
    return 1
  }

  xinput set-prop "$device" "Coordinate Transformation Matrix" \
    $scale    0.0   0.0 \
       0.0 $scale   0.0 \
       0.0    0.0   1.0 \
    && echo "OK" \
    || print_error "FAIL"
}

gpg_export() {
  local program="$0"
  local usage="usage: $program ARCHIVE-NAME [SECRET-KEY...]"

  # arguments
  local name=$1
  [ -z "$name" ]                            \
    && print_error "$usage"                 \
    && print_error "Archive name required!" \
    && return 1

  local archive="${name%.tgz}.tgz"
  [ -e "$archive" ]                                         \
    && print_error "File with archive name already exists." \
    && return 1

  shift && local secretkeys="$@"

  # tmp and tar
  local tmpdir=$(mktemp -d "/tmp/${program}_XXXXXX")
  [ -z "$tmpdir" ]                                         \
    && print_error "Failed to create temporary directory." \
    && return 1

  print_info "Created temporary directory, $tmpdir"

  silent_pushd "$tmpdir"
    print_info "Exporting public keys..."
    gpg --armor --output public-keys.asc \
      --export-options backup --export
    print_info "Exporting secret keys... (may require passphrase!)"
    gpg --armor --output secret-keys.asc \
      --export-options backup --export-secret-keys $secretkeys
    print_info "Exporting secret subkeys... (may require passphrase!)"
    gpg --armor --output secret-subkeys.asc \
      --export-options backup --export-secret-subkeys $secretkeys
    print_info "Exporting ownertrust..."
    gpg --export-ownertrust > owner-trust.txt
    tar -czf archive.tgz *
  silent_popd

  local tmp_archive="$tmpdir/archive.tgz"

  if mv "$tmp_archive" "$archive"; then
    # successfully move to destination
    print_info "Done. Removing temporary directory, $tmpdir"
    \rm -r "$tmpdir"
  else
    # failed to move to destination
    print_error "Failed to move $tmp_archive into destination $archive!"
    print_error "If root is required, move $tmp_archive manually!"
  fi
}

venv() {
  local name="$1"

  [ -z "$name" ] && {
    print_error "usage: venv NAME"
    return 1
  }

  local venv_dir="$XDG_DATA_HOME/virtualenvs" 
  [ -d "$venv_dir" ] || mkdir -p "$venv_dir" || {
    print_error "failed to create $venv_dir"
    return 1
  }

  local venv="$venv_dir/$name"
  [ -d "$venv" ] || {
    read_yes_no "Create $venv?" && {
      python3 -m venv "$venv"
    } || {
      return 0
    }
  }

  source "$venv/bin/activate"
}

unvenv() {
  [ -n "$VIRTUAL_ENV" ] && deactivate
}

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
