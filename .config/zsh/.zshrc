setopt extendedglob

export PS1=$'\n%{\e[90m%}%n@%m %{\e[91m%}%~%{\e[90m%}\n❱%{\e[0m%} '
export PS2=$'%{\e[90m%}❱%{\e[0m%} '
export GPG_TTY=$(tty)

# git
alias dotfiles="git --git-dir=$HOME/.files/ --work-tree=$HOME"
alias glo="git log --oneline"
alias gs="git status"

# systemd
alias userctl="systemctl --user"
alias journal="journalctl -r"
alias poweroff="systemctl poweroff"
alias suspend="systemctl suspend"
alias reboot="systemctl reboot"
alias logout="loginctl terminate-session ''"

# misc. aliases
alias eprof="$EDITOR $XDG_CONFIG_HOME/zsh/.zprofile"
alias erc="$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc"
alias envim="$EDITOR $XDG_CONFIG_HOME/nvim/init.vim"
alias ealac="$EDITOR $XDG_CONFIG_HOME/alacritty/alacritty.yml"
alias eawesome="$EDITOR $XDG_CONFIG_HOME/awesome/rc.lua"
alias exrc="$EDITOR $HOME/.xinitrc"
alias ecompose="$EDITOR $XCOMPOSEFILE"
alias reprofile="source $XDG_CONFIG_HOME/zsh/.zprofile"
alias resource="source $XDG_CONFIG_HOME/zsh/.zshrc"

# date alises for dated directories
alias day="date +'%Y%m%d'"
alias now="date +'%Y%m%d-%H%M%S'"

# cd aliases
alias cdconf="cd $XDG_CONFIG_HOME"
alias cddoc="cd ~/doc/"
alias cdedu="cd ~/edu/"
alias cdimage="cd ~/image"
alias cdsrc="cd ~/src/"
alias cdvideo="cd ~/video"
alias cdvm="cd ~/vm"

alias cdtech="cd ~/doc/text/tech"
alias cdmath="cd ~/doc/text/math"

# miscellaneous aliases
alias cls="clear && l"
alias delswap="rm -irf $HOME/.local/state/nvim/swap/*"
alias diff="diff -u --color=auto"
alias e="$EDITOR"
alias grep="grep -En --color=auto"
alias hexdump="hexdump -C"
alias ls="ls -vAh --group-directories-first --color=auto"
alias l="ls -l"
alias make="make -j8"
alias mpv="mpv --script-opts=osc-timems=yes"
alias pandoc="pandoc --pdf-engine=xelatex"
alias rm="echo Use /usr/bin/rm if you\'re sure you want to delete: "
alias xpp="xournalpp >>& /dev/null"
alias dasm="objdump -d -M intel"
alias open="xdg-open"
alias pdf="zathura >>& /dev/null"

. "$XDG_CONFIG_HOME/zsh/.zshrc_private"
. "$XDG_CONFIG_HOME/zsh/.zshrc_functions"

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
