# env: general
export PS1=$'\n%{\e[90m%}%n@%m %{\e[91m%}%~%{\e[90m%}\n❱%{\e[0m%} '
export PS2=$'%{\e[90m%}❱%{\e[0m%} '

# env: other/obscure/idk
export GPG_TTY=$(tty)

# alias: general
alias e="$EDITOR"
alias l="ls"
alias bt="bluetoothctl"
alias cm="cls && make"
alias pdf="$PDFVIEW"
alias yt="yt-dlp"
alias ls="ls -lAh --group-directories-first --color=auto"
alias ll="ls -lAXh --group-directories-first --color=auto"
alias hd="hexdump -C"
alias nnn="nnn -e"
alias gpr="grep -PRn"
alias llc="ll | wc -l"
alias cls="clear && ls"
alias clsm="cls && make"
alias make="make -j8"
alias open="xdg-open"
alias diff="diff --color=auto"
alias dasm="objdump -d -M intel"
alias cent='for x in {0..100}; do echo $x; done'
alias slog='journalctl -r'
alias today="date '+%Y-%m-%d'"
alias office="libreoffice"
alias delswap="rm -rf ~/.local/share/nvim/swap/"
alias conname="nmcli con show --active | awk '\$1 != \"NAME\" { print(\$1); }'"
alias background='feh --no-fehbg -z --bg-fill "$HOME/doc/images/wallpapers/target/"'
alias todaynice="date +'%A, %B %e, %Y'"

alias memcheck="valgrind --tool=memcheck"
alias callgrind="valgrind --tool=callgrind"

alias killblocks="pidof dwmblocks | xargs kill -9"
alias killpicom="pidof picom | xargs kill -9"

alias eprof="$EDITOR $XDG_CONFIG_HOME/zsh/.zprofile"
alias exrc="$EDITOR $HOME/.xinitrc"
alias erc="$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc"
alias envim="$EDITOR $XDG_CONFIG_HOME/nvim/init.vim"
alias ecompose="$EDITOR $XDG_CONFIG_HOME/X/XCompose"

alias userctl="systemctl --user"
alias poweroff="sudo systemctl poweroff"
alias gosleep="sudo systemctl suspend"
alias reboot="sudo systemctl reboot"
alias redunst="userctl restart dunst"
alias redisplay="pidof dwm | xargs kill -9"
alias resource="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias zreprof="source $XDG_CONFIG_HOME/zsh/.zprofile"
alias vact="source ./venv/bin/activate"

alias config="/usr/bin/git --git-dir=$HOME/.files/ --work-tree=$HOME"
alias cs="config status"

alias glo="git log --oneline"
alias gs="git status"

# alias: cds
alias cdvideo="cd $HOME/doc/video"
alias cdaudio="cd $HOME/doc/audio"
alias cdimage="cd $HOME/doc/images/"

alias cdedu="cd $EDUCATION_HOME"
alias cdra="cd $EDUCATION_HOME/real-analysis"
alias cdlatin="cd $EDUCATION_HOME/lang/latin/"

alias cdds="cd $EDUCATION_HOME/deanza/data-structures"
alias cdla="cd $EDUCATION_HOME/deanza/linear-algebra"
alias cdix="cd $EDUCATION_HOME/deanza/x86-intro"
alias cddm="cd $EDUCATION_HOME/deanza/discrete-math"

alias cdlit="cd $EDUCATION_HOME/fuhsd/lit"
alias cdgov="cd $EDUCATION_HOME/fuhsd/gov"
alias cdmicro="cd $EDUCATION_HOME/fuhsd/micro"


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

audioconcat() {
	OUT=${1:?"audioconcat OUTPUT INPUT..."}
	shift
	OUTIN="$OUT.audioconcat-tmp.in"
	for file in "$@"; do echo "file '$file'"; done > "$OUTIN"
	ffmpeg -f concat \
	       -safe 0 \
	       -i "$OUTIN" \
	       -c copy \
	       "$OUT"
	rm "$OUTIN"
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

lspath() {
	for directory in $(echo "$PATH" | tr ':' '\n'); do
		for file in $(ls "$directory"); do
			echo "$directory/$file"
		done
	done
}

# Notes for my future self:
#
# COREUTILS
# seq - generate ordered numbers
#
# MAGICK
# xc - canvas pseudo-image
