# Uncategorized stuff.

function ls-path() {
  for d in $(echo "$PATH" | tr ':' '\n'); do
    for f in $(/usr/bin/ls "$d"); do
      echo "$d/$f"
    done
  done
}

function ls-gsettings() {
  for schema in $(gsettings list-schemas) $(gsettings list-relocatable-schemas); do
    echo "$schema"
    for key in $(gsettings list-keys $schema); do
      echo "    $key = $(gsettings get $schema $key)"
    done
  done
}

function ls-gcc-defines() {
  gcc -E -dM - < /dev/null
}

function copy-screenshots() {
  sxiv -t -o ~/image/screenshot/ | xargs cp -t ${1:-.}
}

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
