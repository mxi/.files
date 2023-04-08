def _logon_string():
    import os
    import getpass
    import socket
    text_style = "{BOLD_RED}" if os.getuid() == 0 else "{BOLD_WHITE}"
    at_style = "{RED}" if os.getuid() == 0 else "{WHITE}"
    return f"{text_style}{getpass.getuser()}" \
           f"{at_style}@" \
           f"{text_style}{socket.gethostname()}"

def _env_color():
    import xonsh
    env = xonsh.prompt.env.env_name()
    if len(env):
        return "{BOLD_CYAN}"
    return None

def _env_name():
    import xonsh
    env = xonsh.prompt.env.env_name().strip()
    if len(env):
        return f"{env}"
    return None

$PROMPT_FIELDS["_logon_string"] = _logon_string
$PROMPT_FIELDS["_env_color"]    = _env_color
$PROMPT_FIELDS["_env_name"]     = _env_name
$PROMPT_FIELDS["env_prefix"]    = ""
$PROMPT_FIELDS["env_postfix"]   = ""
$PROMPT                         = "\n"                                         \
                                  "{_logon_string}"                            \
                                  "{_env_color}{_env_name: [{}]}{RESET}"       \
                                  "{branch_color}{curr_branch: [{}]}{RESET}"   \
                                  " "                                          \
                                  "{BOLD_WHITE}{cwd}{RESET}\n"                 \
                                  "{BOLD_WHITE}${RESET} "
$MULTILINE_PROMPT               = "{BOLD_WHITE}|{RESET} "

# vi: sw=4 sts=4 ts=4 et cc=80 ft=python
