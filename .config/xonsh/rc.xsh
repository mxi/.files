def _source_if_exists(name):
    file = pf"$XDG_CONFIG_HOME/xonsh/{name}.xsh"
    if file.exists():
        source @(file)

# xonsh env
$AUTO_SUGGEST_IN_COMPLETIONS = True
$AUTO_SUGGEST = True
$VI_MODE = True
$GPG_TTY = $(tty)

$VIRTUALENV_HOME = f"{$XDG_DATA_HOME}/virtualenvs"
xontrib load vox

_source_if_exists("prompt")

# git
aliases["dotfiles"]    = "git --git-dir=$HOME/.files/ --work-tree=$HOME"
aliases["glo"]         = "git log --oneline"
aliases["gs"]          = "git status"

# systemd
aliases["userctl"]     = "systemctl --user"
aliases["journal"]     = "journalctl -r"
aliases["poweroff"]    = "systemctl poweroff"
aliases["suspend"]     = "systemctl suspend"
aliases["reboot"]      = "systemctl reboot"
aliases["logout"]      = "loginctl terminate-session ''"

# quicksource / quickedit
aliases["ealac"]       = "$EDITOR $XDG_CONFIG_HOME/alacritty/alacritty.yml"
aliases["eawesome"]    = "$EDITOR $XDG_CONFIG_HOME/awesome/rc.lua"
aliases["ecompose"]    = "$EDITOR $XCOMPOSEFILE"
aliases["envim"]       = "$EDITOR $XDG_CONFIG_HOME/nvim/init.vim"
aliases["ezprof"]      = "$EDITOR $XDG_CONFIG_HOME/zsh/.zprofile"
aliases["ezrc"]        = "$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc"
aliases["ezrcf"]       = "$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc_functions"
aliases["exrc"]        = "$EDITOR $XDG_CONFIG_HOME/xonsh/rc.xsh"
aliases["exinit"]      = "$EDITOR $HOME/.xinitrc"
aliases["ezathura"]    = "$EDITOR $XDG_CONFIG_HOME/zathura/zathurarc"
aliases["resource"]    = "source $XDG_CONFIG_HOME/xonsh/rc.xsh"

# dates
aliases["day"]         = "date +'%Y%m%d'"
aliases["now"]         = "date +'%Y%m%d-%H%M%S'"

# cd aliases
aliases["cdconf"]      = "cd $XDG_CONFIG_HOME"
aliases["cdxonsh"]     = "cd $XDG_CONFIG_HOME/xonsh"
aliases["cddecoldest"] = "cd ~/.config/nvim/pack/color/start/decoldest"
aliases["cddoc"]       = "cd ~/doc"
aliases["cdedu"]       = "cd ~/edu"
aliases["cdimage"]     = "cd ~/image"
aliases["cdsrc"]       = "cd ~/src"
aliases["cdvideo"]     = "cd ~/video"
aliases["cdvirt"]      = "cd ~/virt"

# miscellaneous aliases
aliases["cls"]         = "clear && l"
aliases["clm"]         = "clear && make"
aliases["diff"]        = "diff -u --color=auto"
aliases["e"]           = "$EDITOR"
aliases["v"]           = $(which neovide)
aliases["grep"]        = "grep -En --color=auto"
aliases["hexdump"]     = "hexdump -C"
aliases["ls"]          = "ls -vAh --group-directories-first --color=auto"
aliases["l"]           = "ls -l"
aliases["make"]        = "make -j8"
aliases["mpv"]         = "mpv --script-opts=osc-timems=yes"
aliases["pandoc"]      = "pandoc --pdf-engine=xelatex"
aliases["xpp"]         = "xournalpp @($args) all> /dev/null"
aliases["dasm"]        = "objdump -d -M intel"
aliases["open"]        = "xdg-open"
aliases["pdf"]         = "zathura @($args) all> /dev/null"

_source_if_exists("helpers")
_source_if_exists("private")

# vi: sw=4 sts=4 ts=4 et cc=80 ft=python
