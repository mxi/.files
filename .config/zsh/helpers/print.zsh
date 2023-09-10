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

print-debug() {
  local print__style="$reset_color"
  print_ "$@"
}

print-info() {
  local print__style="$fg[white]"
  print_ "$@"
}

print-warning() {
  local print__style="$fg[yellow]"
  print_ "$@"
}

print-error() {
  local print__style="$fg[red]"
  print_ "$@"
}

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
