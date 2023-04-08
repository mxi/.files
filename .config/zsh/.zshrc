setopt extendedglob
setopt prompt_subst

unalias run-help >& /dev/null
autoload -U run-help
autoload -U colors && colors
autoload -U compinit && compinit

. "$XDG_CONFIG_HOME/zsh/.zshrc_prompt"

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

# quicksource / quickedit
alias ealac="$EDITOR $XDG_CONFIG_HOME/alacritty/alacritty.yml"
alias eawesome="$EDITOR $XDG_CONFIG_HOME/awesome/rc.lua"
alias ecompose="$EDITOR $XCOMPOSEFILE"
alias envim="$EDITOR $XDG_CONFIG_HOME/nvim/init.vim"
alias eprof="$EDITOR $XDG_CONFIG_HOME/zsh/.zprofile"
alias ezrc="$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc"
alias ezrcfn="$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc_functions"
alias exinit="$EDITOR $HOME/.xinitrc"
alias ezathura="$EDITOR $XDG_CONFIG_HOME/zathura/zathurarc"
alias reprofile="source $XDG_CONFIG_HOME/zsh/.zprofile"
alias resource="source $XDG_CONFIG_HOME/zsh/.zshrc"

# dates
alias day="date +'%Y%m%d'"
alias now="date +'%Y%m%d-%H%M%S'"

# cd aliases
alias cdconf="cd $XDG_CONFIG_HOME"
alias cddoc="cd ~/doc/"
alias cdedu="cd ~/edu/"
alias cdimage="cd ~/image"
alias cdsrc="cd ~/src"
alias cdvideo="cd ~/video"
alias cdvirt="cd ~/virt"

# miscellaneous aliases
alias cls="clear && l"
alias clm="clear && make"
alias delswap="/usr/bin/rm -irf $HOME/.local/state/nvim/swap/*; /usr/bin/rm -irf $HOME/.local/share/nvim/swap/*"
alias diff="diff -u --color=auto"
alias e="$EDITOR"
alias v="/usr/bin/neovide"
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
