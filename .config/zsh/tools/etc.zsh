# Uncategorized stuff.

ls-path() {
  for d in $(echo "$PATH" | tr ':' '\n'); do
    for f in $(/usr/bin/ls "$d"); do
      echo "$d/$f"
    done
  done
}

ls-gsettings() {
  for schema in $(gsettings list-schemas) $(gsettings list-relocatable-schemas); do
    echo "$schema"
    for key in $(gsettings list-keys $schema); do
      echo "    $key = $(gsettings get $schema $key)"
    done
  done
}

ls-gcc-defines() {
  gcc -E -dM - < /dev/null
}

set-color-preference() {
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

copy-screenshots() {
  sxiv -t -o ~/image/screenshot/ | xargs cp -t ${1:-.}
}

delete-nvim-swapfiles() {
  \rm -irf "$HOME/.local/state/nvim/swap/"*
  \rm -irf "$HOME/.local/share/nvim/swap/"*
}

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
