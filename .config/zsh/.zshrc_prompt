_prompt_logon() {
  # echos 'USER@HOSTNAME' 
  #   where USER and HOSTNAME are the directives for ZSH to replace with the
  #   actual user and hostname. Additionally, if we're root, we make it red so 
  #   to intimidate us in the hopes of avoiding mistakes.
  local R=$(print "%{$reset_color%}")

  [ "$(id -u)" -eq 0 ] && {
    local C=$(print "%{$fg_bold[red]%}")
    local c=$(print "%{$fg_no_bold[red]%}")
  } || {
    local C=$(print "%{$fg_bold[white]%}")
    local c=$(print "%{$fg_no_bold[white]%}")
  }

  echo -n "${C}%n${c}@${C}%m${R}"
}

_prompt_ssh() {
  # echos '[ADDR]' 
  #   where ADDR is the client IP address, if we're in an SSH session, bolded 
  #   red. If not in SSH, nothing is echo'd.
  if [ -n "$SSH_CONNECTION" ]; then
    local C="%{$fg_bold[red]%}"
    local R="%{$reset_color%}"
    local addr=$(echo -n $SSH_CONNECTION | cut -d' ' -f1)
    echo -n "${C}[$addr]${R}"
  fi
}

_prompt_git() {
  # echos '[HEAD]' 
  #   where HEAD is the current head of the git repository we're in, bolded 
  #   green. If it's a detached HEAD, the first 5 characters of the commit's 
  #   SHA1 is shown in bolded yellow. If not in a repo, nothing is echo'd.
  local head style name

  if head="$(git 2>/dev/null symbolic-ref HEAD)"; then {
    # symbolic ref
    style="$(echo -n "%{$fg_bold[green]%}")"
    name="${head#refs/heads/}"
  }
  elif head="$(git 2>/dev/null rev-parse HEAD)"; then {
    # detached head
    style="$(echo -n "%{$fg_bold[yellow]%}")"
    name="${head[1,5]}"
  } 
  fi

  [ -n "$name" ] && {
    echo -n "${style}[$name]%{$reset_color%}"
  }
}

_prompt_venv() {
  # echos '[venv]'
  #   if there is an active virtual environment.
  [ -n "$VIRTUAL_ENV" ] && {
    local C="%{$fg_bold[cyan]%}"
    local Y="%{$fg_bold[yellow]%}"
    local R="%{$reset_color%}"
    echo -n "${C}[${Y}$(basename "$VIRTUAL_ENV")${C}]${R}"
  }
}

_prompt_cwd() {
  # echos 'CWD' 
  #   where CWD is the current working directory, bolded. 
  local C="%{$fg_bold[white]%}"
  local R="%{$reset_color%}"
  echo -n "${C}%~${R}"
}

_prompt_indicator() {
  # echos 'IND' 
  #   where IND is the desired indicator or '$' by default, bolded.
  [ "$(id -u)" -eq 0 ] && {
    local def='#'
  } || {
    local def='$'
  }
  local C="%{$fg_bold[white]%}"
  local R="%{$reset_color%}"
  local I="${1:-$def}"
  echo -n "${C}${I}${R}"
}

_prompt1() {
  local builder=""

  local logon="$(_prompt_logon)"
  [ -n "$logon" ] && builder+="$logon"

  local ssh="$(_prompt_ssh)"
  [ -n "$ssh" ] && builder+=" $ssh"

  local git="$(_prompt_git)"
  [ -n "$git" ] && builder+=" $git"

  local venv="$(_prompt_venv)"
  [ -n "$venv" ] && builder+=" $venv"

  local cwd="$(_prompt_cwd)"
  [ -n "$cwd" ] && builder+=" $cwd"

  builder+="\n"

  local indicator="$(_prompt_indicator)"
  [ -n "$indicator" ] && builder+="$indicator "

  echo -n "$builder"
}

_prompt2() {
  echo -n "$(_prompt_indicator '|') "
}

PS1=$'$(_prompt1)'
PS2=$'$(_prompt2)'

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
