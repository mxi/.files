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
