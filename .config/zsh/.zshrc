# env: general
export PS1=$'\n\e[90m%n@%m \e[91m%~\e[90m\n❱\e[0m '
export PS2=$'\e[90m❱\e[0m '

# env: other/obscure/idk
export GPG_TTY=$(tty)

# all other envs in this script are part of .zprofile


# alias: general
alias e="$EDITOR"
alias pdf="$PDFVIEW"
alias ls="ls --color=auto"
alias ll="ls -lAX"
alias l="ll"
alias llc="ll | wc -l"
alias cls="clear && ll"
alias diff="diff --color=auto"
alias dasm="objdump -d -M intel"
alias cent='for x in {0..100}; do echo $x; done'
alias conname="nmcli con show --active | awk '\$1 != \"NAME\" { print(\$1); }'"
alias background='feh --no-fehbg -z --bg-fill "$HOME/doc/photos/wallpapers/"'
alias today="date '+%Y-%m-%d'"
alias todaynice="date +'%A, %B %e, %Y'"

alias killblocks="pidof dwmblocks | xargs kill -9"
alias killpicom="pidof picom | xargs kill -9"

alias eprof="$EDITOR $XDG_CONFIG_HOME/zsh/.zprofile"
alias exrc="$EDITOR $HOME/.xinitrc"
alias erc="$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc"
alias envim="$EDITOR $XDG_CONFIG_HOME/nvim/init.vim"
alias ecompose="$EDITOR $XDG_CONFIG_HOME/X/XCompose"

alias poweroff="sudo systemctl poweroff"
alias gosleep="sudo systemctl suspend"
alias reboot="sudo systemctl reboot"
alias redisplay="pidof dwm | xargs kill -9"
alias redunst="systemctl --user restart dunst"
alias resource="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias zreprof="source $XDG_CONFIG_HOME/zsh/.zprofile"
alias vact="source ./venv/bin/activate"

alias config="/usr/bin/git --git-dir=$HOME/.df/ --work-tree=$HOME"
alias cs="config status"
alias gs="git status"


# alias: school
alias cdschool="cd $SCHOOL_HOME"
alias cdagenda="cd $SCHOOL_HOME/agenda"

alias cdds="cd $SCHOOL_HOME/deanza/ds"
alias cdla="cd $SCHOOL_HOME/deanza/la"

alias cdlit="cd $SCHOOL_HOME/fuhsd/lit"
alias cdgov="cd $SCHOOL_HOME/fuhsd/gov"


# functions: general
saveimg() {
	xwd | convert xwd:- png:- > "$@.png"
}

saveclip() {
	xwin2mp4.sh "$@"
}

pdfmerge() {
	if [ -z $1 -o -z $2 ]; then
		echo "usage: pdfmerge OUTPUT INPUT..."
		return 1
	fi
	OUT=$1
	if [ -e $OUT ]; then
		echo "Output file already exists: aborting."
		return 2
	fi
	shift
	/usr/bin/gs -dBATCH -dNOPAUSE -q \
	            -sDEVICE=pdfwrite -sOutputFile="$OUT" $@
}

randaround() {
	[ "$1" = "pad" ] && PAD=1 && shift || PAD=0
	# user supplied side economics
	CENTER=${1:?"Usage: randaround [pad] CENTER RADIUS N"}
	RADIUS=${2:?"Usage: randaround [pad] CENTER RADIUS N"}
	N=${3:?"Usage: randaround [pad] CENTER RADIUS N"}
	# mathematical preparation
	MIN=$((CENTER-RADIUS))
	RANGE=$((2*RADIUS))
	for x in $(shuf -i 0-$RANGE -n $N); do
		y=$((x+MIN))
		[ "$PAD" = "1" ]       && \
			printf "%16d\n" $y || \
			echo $y
	done
}
