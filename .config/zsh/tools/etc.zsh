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

concat_audio_files() {
  local usage="usage: concat_audio_files OUTPUT INPUT..."
  local output="$1" && shift >&/dev/null || {
    print_error "$usage"
    return 1
  }

  local inputs=()
  local filter=""
  typeset -i index=0

  for file in "$@"; do
    inputs+=("-i" "$file")
    filter+="[${index}:a]"
    index+=1
  done

  filter+="concat=n=${index}:v=0:a=1 [a]"

  ffmpeg $inputs -filter_complex "$filter" -map '[a]' "$output"
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

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
