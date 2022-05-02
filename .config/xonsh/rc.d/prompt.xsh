def _get_tmux_window():
    if "TMUX" not in __xonsh__.env:
        return None
    return $(tmux display-message -p "#I").strip()

def _clean_ret_code():
    retcode = $PROMPT_FIELDS["ret_code"]()
    if not retcode:
        return None
    retcode = retcode.replace("[", "")
    retcode = retcode.replace("]", "")
    return retcode

def _count_jobs():
    jobs = len($(jobs).split("\n")) - 1
    return jobs if jobs > 0 else None

$PROMPT_FIELDS["userstr"] = lambda: None if $(whoami) == "cunha\n" else $(whoami).strip()
$PROMPT_FIELDS["tmuxwin"] = _get_tmux_window
$PROMPT_FIELDS["clean_ret_code"] = _clean_ret_code
$PROMPT_FIELDS["background_jobs"] = _count_jobs
$PROMPT_FIELDS["env_prefix"] = ""
$PROMPT_FIELDS["env_postfix"] = ""

$PROMPT = "".join([
    "{vte_new_tab_cwd}",
    "{tmuxwin:{} }"
    "{userstr:{GREEN}{}{RESET}@}",
    "{RED}{hostname}{RESET}",
    ":",
    "{BLUE}{cwd_dir}{cwd_base}{RESET}",
    " {YELLOW}{prompt_end}{RESET} ",
])

$RIGHT_PROMPT = "".join([
    "{clean_ret_code:{RED}{}r{RESET}} ",
    "{background_jobs:{YELLOW}{}j{RESET} }",
    "{PURPLE}{curr_branch:{}}{RESET} ",
    "{env_name:{INTENSE_PURPLE}{}{RESET}} ",
    "{INTENSE_BLACK}{localtime}{RESET}"
])

$BOTTOM_TOOLBAR = ""