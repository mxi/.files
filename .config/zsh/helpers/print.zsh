# In addition to the `color' autoloaded functions, these helpers make writing
# tools a bit nicer and give them more polish.

print_() >&2 {
  # PUBLIC ENV
  #   + program_name := an optional name of the program.
  # PRIVATE ENV
  #   - print__style := escape sequences to prefix the message.
  #
  [ -n "$program_name" ]                                     \
    && local print__prefix="${print__style}[$program_name] " \
    || local print__prefix="${print__style}"
  print "${print__prefix}$@$reset_color"
}

print_debug() {
  local print__style="$reset_color"
  print_ "$@"
}

print_info() {
  local print__style="$fg[white]"
  print_ "$@"
}

print_warning() {
  local print__style="$fg[yellow]"
  print_ "$@"
}

print_error() {
  local print__style="$fg[red]"
  print_ "$@"
}

read_yes_no() {
  local prompt="${1:-prompt needed}"
  local answer="__null__"
  while [[ "YES" != "$answer:u"* ]] && [[ "NO" != "$answer:u"* ]]; do
    echo -n "$prompt (y/n): "
    read answer
  done
  [[ "YES" = "$answer:u"* ]] && return 0 || return 1
}

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
