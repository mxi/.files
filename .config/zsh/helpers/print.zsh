# In addition to the `color' autoloaded functions, these helpers make writing
# tools a bit nicer and give them more polish.

_print() >&2 {
  # PUBLIC ENV
  #   + program_name := an optional name of the program.
  # PRIVATE ENV
  #   - _print_style := escape sequences to prefix the message.
  #
  [ -n "$program_name" ]                                     \
    && local _print_prefix="${_print_style}[$program_name] " \
    || local _print_prefix="${_print_style}"
  print "${_print_prefix}$@$reset_color"
}

print-debug() {
  local _print_style="$reset_color"
  _print "$@"
}

print-info() {
  local _print_style="$fg[white]"
  _print "$@"
}

print-warning() {
  local _print_style="$fg[yellow]"
  _print "$@"
}

print-error() {
  local _print_style="$fg[red]"
  _print "$@"
}

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
