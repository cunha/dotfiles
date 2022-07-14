import os

def _get_tmux_window():
    if "TMUX" not in __xonsh__.env:
        return None
    return $(tmux display-message -p "#I").strip()

def _get_status_line():
    status = []
    retcode = $PROMPT_FIELDS["last_return_code"]()
    if retcode != 0:
        status.append("{BOLD_INTENSE_RED}%dr{RESET}" % retcode)
    jobscnt = len($(jobs).split("\n")) - 1
    if jobscnt > 0:
        status.append("{YELLOW}%dj{RESET}" % jobscnt)
    return (" ".join(status) + "\n") if status else ""

def _env_name_custom():
    env_path = __xonsh__.env.get("VIRTUAL_ENV", None)
    if env_path is None:
        return None
    env_name = os.path.basename(env_path)
    return env_name

$PROMPT_FIELDS["userstr"] = lambda: None if $(whoami) == "cunha\n" else $(whoami).strip()
$PROMPT_FIELDS["tmuxwin"] = _get_tmux_window
$PROMPT_FIELDS["status_line"] = _get_status_line
$PROMPT_FIELDS["env_name_cust"] = _env_name_custom
$PROMPT_FIELDS["env_prefix"] = None
$PROMPT_FIELDS["env_postfix"] = None

$PROMPT = "".join([
    "{status_line}",
    "{vte_new_tab_cwd}",
    "{tmuxwin:{} }",
    "{userstr:{GREEN}{}{RESET}@}",
    "{RED}{hostname}{RESET}",
    ":",
    "{BLUE}{cwd_dir}{cwd_base}{RESET}",
    "{curr_branch: {PURPLE}{}{RESET}}",
    "{env_name_cust: {INTENSE_PURPLE}{}{RESET}}",
    " {GREEN}{last_return_code_if_nonzero:{RED}}{prompt_end}{RESET} ",
])

$RIGHT_PROMPT_UNUSED = "".join([
    "{INTENSE_BLACK}{localtime}{RESET}"
])

$RIGHT_PROMPT = ""

$BOTTOM_TOOLBAR = ""