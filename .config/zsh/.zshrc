export GPG_TTY=$(tty)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# bootstrap 
setopt extendedglob
setopt promptsubst

unalias run-help >& /dev/null
autoload -U run-help
autoload -U colors && colors
autoload -U compinit && compinit

. "$ZDOTDIR/.zshrc_prompt"

[ -d "$ZDOTDIR/helpers" ] && for helper in $(ls "$ZDOTDIR/helpers"); do
  . "$ZDOTDIR/helpers/$helper"
done

[ -d "$ZDOTDIR/tools" ] && for tool in $(ls "$ZDOTDIR/tools"); do
  . "$ZDOTDIR/tools/$tool"
done

# git
alias dotfiles="git --git-dir=$HOME/.files/ --work-tree=$HOME"
alias gco="git cat-file --batch-check --batch-all-objects"
alias glo="git log --oneline"
alias gs="git status"

# systemd
alias userctl="systemctl --user"
alias journal="journalctl -r"
alias poweroff="systemctl poweroff"
alias suspend="systemctl suspend"
alias reboot="systemctl reboot"
alias logout="loginctl terminate-session ''"

# quicksource / quickedit
alias ealac="$EDITOR $XDG_CONFIG_HOME/alacritty/alacritty.yml"
alias eawesome="$EDITOR $XDG_CONFIG_HOME/awesome/rc.lua"
alias ecompose="$EDITOR $XCOMPOSEFILE"
alias edotmap="$EDITOR $HOME/.local/bin/dotmap"
alias envim="$EDITOR $XDG_CONFIG_HOME/nvim/init.vim"
alias exinit="$EDITOR $HOME/.xinitrc"
alias ezathura="$EDITOR $XDG_CONFIG_HOME/zathura/zathurarc"
alias ezprof="$EDITOR $ZDOTDIR/.zprofile"
alias ezrc="$EDITOR $ZDOTDIR/.zshrc"
alias ezprompt="$EDITOR $ZDOTDIR/.zshrc_prompt"
alias ezetc="$EDITOR $ZDOTDIR/tools/etc.zsh"
alias reprofile="source $ZDOTDIR/.zprofile"
alias resource="source $ZDOTDIR/.zshrc"

# dates
alias day="date +'%Y%m%d'"
alias now="date +'%Y%m%d-%H%M%S'"

# cd
alias cdconf="cd $XDG_CONFIG_HOME"
alias cddoc="cd ~/doc/"
alias cdedu="cd ~/edu/"
alias cdimage="cd ~/image"
alias cdsrc="cd ~/src"
alias cdvideo="cd ~/video"
alias cdvmrack="cd ~/vmrack"

# coreutils
alias grep="grep -En --color=auto"
alias ls="ls -vAh --group-directories-first --color=auto"
alias l="ls -l"

# miscellaneous aliases
alias diff="diff -u --color=auto"
alias cls="clear && l"
alias clm="clear && make"
alias e="$EDITOR"
alias v="/usr/bin/neovide"
alias hexdump="hexdump -C"
alias make="make -j8"
alias mpv="mpv --script-opts=osc-timems=yes"
alias pandoc="pandoc --pdf-engine=xelatex"
alias rm="echo 'be careful, partner.'; false"
alias xpp="xournalpp >>& /dev/null"
alias dasm="objdump -d -M intel"
alias open="xdg-open"
alias pdf="zathura >>& /dev/null"
alias nnn="nnn -de"

. $ZDOTDIR/.zshrc_private

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
