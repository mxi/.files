# Uncategorized stuff.

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

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
