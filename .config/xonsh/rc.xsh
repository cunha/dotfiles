import os

$UPDATE_OS_ENVIRON = True
$SHELL = "xonsh"
$FOREIGN_ALIASES_SUPPRESS_SKIP_MESSAGE = True
$COLORTERM = "truecolor"

$DEBEMAIL = "cunha@dcc.ufmg.br"
$DEBFULLNAME = "Italo Cunha"

$PATH.add(p"$HOME/bin", front=True)
$PATH.add(p"$HOME/.local/bin", front=True)
$PATH.add("/sbin")
$PATH.add("/usr/sbin")
if os.path.exists(p"$HOME/.cargo/bin"):
    $PATH.add(p"$HOME/.cargo/bin")
if os.path.exists(p"$HOME/.julia/bin"):
    $PATH.add(p"$HOME/.julia/bin")

winpath = p"/mnt/c/Users/$USER/AppData/Local/Programs/Microsoft VS Code/bin"
if os.path.exists(winpath):
    $PATH.add(winpath)
else:
    if "VSCODE_GIT_ASKPASS_NODE" in ${...}:
        sshpath = f"{$VSCODE_GIT_ASKPASS_NODE}/bin/remote-cli".replace("node/", "")
        if os.path.exists(sshpath):
            $PATH.add(sshpath)

if $(which code).startswith("/"):
    $EDITOR = "code"
if $(which vim).startswith("/"):
    $EDITOR = "vim"
else:
    $EDITOR = "vi"
$VISUAL = $EDITOR

xontrib load coreutils
xontrib load whole_word_jumping
xontrib load vox
xontrib load autovox

xontrib load docker_tabcomplete
xontrib load apt_tabcomplete

# TODO: Figure out how to re-alias dirs to dirs -vl  (rc.d/aliases.xsh)
# TODO: Print run time of long-running processes; bash/zsh REPORTTIME env

# Set up history
$HISTCONTROL = set(["ignoredups"])
$XONSH_HISTORY_SAVE_CWD = True
$XONSH_HISTORY_SIZE = (1<<16, "commands")

@events.on_postcommand
def _xonsh_cunha_write_local_history(
    cmd: str,
    rtn: int,
    out: str or None,
    ts: list
) -> None:
    MAX_LOCAL_HIST_SIZE = (1 << 20)  # 1 MiB
    NO_HISTORY_PATHS = list(str(p) for p in [
        p"$HOME/Desktop",
        p"$HOME/Dropbox",
        p"$HOME/GDrive",
        p"$HOME/OneDrive",
        p"$HOME/ownCloud",
    ])
    cwd = __xonsh__.env.get("PWD")
    if not os.access(cwd, os.W_OK):
        return
    for path in NO_HISTORY_PATHS:
        if cwd.startswith(str(path)):
            return
    histfile = os.path.join(cwd, ".xshlocal")
    # Write first to ensure file exists in the size check below
    with open(histfile, "a", encoding="utf8") as fd:
        fd.write(cmd)
    if os.path.getsize(histfile) > MAX_LOCAL_HIST_SIZE:
        tail --bytes @(MAX_LOCAL_HIST_SIZE // 2) @(histfile) \
                > @(histfile).tmp
        os.rename(f"{histfile}.tmp", histfile)
        print_color(f"{ORANGE}Resized .xshlocal{RESET}")

# Checks and warnings
if $(which xclip).startswith("xclip not in"):
    print_color("{YELLOW}xclip not found.{RESET}")
else:
    if "DISPLAY" not in ${...}:
        print_color("{YELLOW}xclip found, but no X11 DISPLAY.{RESET}")

# Reload ENV in tmux shells
@events.on_precommand
def _update_tmux_env(cmd: str) -> None:
    if "TMUX" in __xonsh__.env:
        tmux rename-window @(cmd.split()[0])

        sock = $(tmux show-environment SSH_AUTH_SOCK).split("=")[1].strip()
        if sock != __xonsh__.env.get("SSH_AUTH_SOCK", "/fail"):
            $SSH_AUTH_SOCK = sock
            print_color("{YELLOW}SSH_AUTH_SOCK updated.{RESET}")

        # bash_string = $(tmux show-environment DISPLAY).strip()
        # if bash_string != "-DISPLAY":
        #     source-bash @(bash_string)
        #     print_color("{YELLOW}DISPLAY updated.{RESET}")

        if cmd.startswith("code"):
            vars = ["VSCODE_IPC_HOOK_CLI", "VSCODE_GIT_ASKPASS_NODE",
                    "VSCODE_GIT_ASKPASS_MAIN", "VSCODE_GIT_IPC_HANDLE"]
            for v in vars:
                if not os.path.exists(__xonsh__.env.get(v, "/fail")):
                    source-bash $(tmux show-environment @(v))
                    print_color("{YELLOW}%s updated.{RESET}" % v)

@events.on_pre_prompt
def _update_tmux_window() -> None:
    if "TMUX" in __xonsh__.env:
        title = os.path.basename(__xonsh__.env.get("PWD"))
        tmux rename-window @(title)

@events.autovox_policy
def home_virtualenvs_policy(path, **_):
    basename = os.path.basename(path)
    venv = p"$HOME/.virtualenvs" / basename
    if venv.exists():
        return venv

##############################################################################
# Configurables:
##############################################################################

# uncomment the following to start and connect to an SSH agent
source-bash $(keychain --quiet --eval --agents ssh)

# uncomment the following to prevent others from reading our files
# umask 007

# _update_tmux_window("", 0, "", [])
