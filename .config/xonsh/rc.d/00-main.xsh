$AUTO_SUGGEST       = False
$VI_MODE            = True
$PROMPT             = "\n" \
                      "{BOLD_WHITE}{user}{WHITE}@{BOLD_WHITE}{hostname}{RESET} " \
                      "{BOLD_WHITE}{cwd}{RESET} " \
                      "{branch_color}{curr_branch:[{}]}{RESET}\n" \
                      "{BOLD_WHITE}${RESET} "
$MULTILINE_PROMPT   = "{BOLD_WHITE}|{RESET} "
$GPG_TTY            = $(tty)

# git
aliases["dotfiles"] = "git --git-dir=$HOME/.files/ --work-tree=$HOME"
aliases["glo"]      = "git log --oneline"
aliases["gs"]       = "git status"

# systemd
aliases["userctl"]  = "systemctl --user"
aliases["journal"]  = "journalctl -r"
aliases["poweroff"] = "systemctl poweroff"
aliases["suspend"]  = "systemctl suspend"
aliases["reboot"]   = "systemctl reboot"
aliases["logout"]   = "loginctl terminate-session ''"

# quicksource / quickedit
aliases["ealac"]    = "$EDITOR $XDG_CONFIG_HOME/alacritty/alacritty.yml"
aliases["eawesome"] = "$EDITOR $XDG_CONFIG_HOME/awesome/rc.lua"
aliases["ecompose"] = "$EDITOR $XCOMPOSEFILE"
aliases["envim"]    = "$EDITOR $XDG_CONFIG_HOME/nvim/init.vim"
aliases["ezprof"]   = "$EDITOR $XDG_CONFIG_HOME/zsh/.zprofile"
aliases["ezprofp"]  = "$EDITOR $XDG_CONFIG_HOME/zsh/.zprofile_private"
aliases["ezrc"]     = "$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc"
aliases["ezrcf"]    = "$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc_functions"
aliases["ezrcp"]    = "$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc_private"
aliases["exmain"]   = "$EDITOR $XDG_CONFIG_HOME/xonsh/rc.d/00-main.xsh"
aliases["expriv"]   = "$EDITOR $XDG_CONFIG_HOME/xonsh/rc.d/10-private.xsh"
aliases["exrc"]     = "$EDITOR $HOME/.xinitrc"
aliases["ezathura"] = "$EDITOR $XDG_CONFIG_HOME/zathura/zathurarc"
aliases["resource"] = lambda: $[source g`$XDG_CONFIG_HOME/xonsh/rc.d/*.xsh`]

# dates
aliases["day"]      = "date +'%Y%m%d'"
aliases["now"]      = "date +'%Y%m%d-%H%M%S'"

# cd aliases
aliases["cdconf"]   = "cd $XDG_CONFIG_HOME"
aliases["cddoc"]    = "cd ~/doc/"
aliases["cdmath"]   = "cd ~/doc/text/math"
aliases["cdtech"]   = "cd ~/doc/text/tech"
aliases["cdedu"]    = "cd ~/edu/"
aliases["cdimage"]  = "cd ~/image"
aliases["cdsrc"]    = "cd ~/src"
aliases["cdvideo"]  = "cd ~/video"
aliases["cdvirt"]   = "cd ~/virt"

# miscellaneous aliases
def _stub_rm(args):
    print(f"use /usr/bin/rm if you're sure you want to delete: {args}")

aliases["cls"]      = "clear && l"
aliases["clm"]      = "clear && make"
aliases["diff"]     = "diff -u --color=auto"
aliases["e"]        = "$EDITOR"
aliases["v"]        = "/usr/bin/neovide"
aliases["grep"]     = "grep -En --color=auto"
aliases["hexdump"]  = "hexdump -C"
aliases["ls"]       = "ls -vAh --group-directories-first --color=auto"
aliases["l"]        = "ls -l"
aliases["make"]     = "make -j8"
aliases["mpv"]      = "mpv --script-opts=osc-timems=yes"
aliases["pandoc"]   = "pandoc --pdf-engine=xelatex"
aliases["rm"]       = _stub_rm
aliases["xpp"]      = "xournalpp >>& /dev/null"
aliases["dasm"]     = "objdump -d -M intel"
aliases["open"]     = "xdg-open"
aliases["pdf"]      = "zathura >>& /dev/null"

# vi: sw=4 sts=4 ts=4 et cc=80 ft=python
