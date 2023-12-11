colors() {
  # Ripped from the colors autoload and made a bit nicer.
  typeset -Ag color=(
    00  none 
    01  bold 
    02  faint 
    03  italic 
    04  underline 
    05  blink 
    07  reverse 
    08  conceal 
    22  normal 
    23  no-italic 
    24  no-underline 
    25  no-blink 
    27  no-reverse 
    28  no-conceal 
    30  black 
    31  red 
    32  green
    33  yellow 
    34  blue 
    35  magenta 
    36  cyan 
    37  white 
    39  default 
    40  bg-black 
    41  bg-red 
    42  bg-green 
    43  bg-yellow 
    44  bg-blue 
    45  bg-magenta 
    46  bg-cyan 
    47  bg-white 
    49  bg-default
  )

  local k

  # add reverse mapping
  for k in ${(k)color}; do
    color[${color[$k]}]=$k
  done

  # create fg-* keys for ANSI color codes 3x for any x
  for k in ${color[(I)3?]}; do
    color[fg-${color[$k]}]=$k
  done

  for k in grey gray; do
    color[$k]=${color[black]}
    color[fg-$k]=${color[$k]}
    color[bg-$k]=${color[bg-black]}
  done

  local lc=$'\e[' rc=m

  typeset -Hg reset_color bold_color
  reset_color="$lc${color[none]}$rc"
  bold_color="$lc${color[bold]}$rc"

  typeset -AHg fg fg_bold fg_no_bold
  for k in ${(k)color[(I)fg-*]}; do
    fg[${k#fg-}]="$lc${color[$k]}$rc"
    fg_bold[${k#fg-}]="$lc${color[bold]};${color[$k]}$rc"
    fg_no_bold[${k#fg-}]="$lc${color[normal]};${color[$k]}$rc"
  done

  typeset -AHg bg bg_bold bg_no_bold
  for k in ${(k)color[(I)bg-*]}; do
    bg[${k#bg-}]="$lc${color[$k]}$rc"
    bg_bold[${k#bg-}]="$lc${color[bold]};${color[$k]}$rc"
    bg_no_bold[${k#bg-}]="$lc${color[normal]};${color[$k]}$rc"
  done
}

print_() >&2 {
  # +program_name: an optional name of the program.
  # -print_style: escape sequences to prefix the message.
  #
  [ -t 1 ] && {
    local ok="$reset_color"
    local style="$print_style"
  } || {
    local ok=""
    local style=""
  }
  [ -n "$program_name" ] && {
    local prefix="${style}[$program_name] "
  } || { 
    local prefix="${style}"
  }
  local IFS="" && print "$prefix$*$ok"
}

print_debug() {
  local print_style="$reset_color"
  print_ "$@"
}

print_info() {
  local print_style="$fg[white]"
  print_ "$@"
}

print_warning() {
  local print_style="$fg[yellow]"
  print_ "$@"
}

print_error() {
  local print_style="$fg[red]"
  print_ "$@"
}

silent_type() >&/dev/null {
  type "$@"
}

silent_pushd() >&/dev/null {
  pushd "$@"
}

silent_popd() >&/dev/null {
  popd
}

read_yes_no() {
  local prompt="${1:-prompt needed}"
  local answer
  while [ "${#answer}" -eq 0 ] || { 
    [[ "YES" != "$answer:u"* ]] && [[ "NO" != "$answer:u"* ]]
  }
  do
    echo -n "$prompt (y/n): "
    read answer
  done
  [[ "YES" = "$answer:u"* ]] && return 0 || return 1
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

colors

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
