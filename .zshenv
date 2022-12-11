unsetopt GLOBAL_RCS
source "$HOME/.config/zsh/aliases"
source "$HOME/.config/zsh/sysenv"
source "$HOME/.config/zsh/ssh"
if [[ -s "$HOME/.hostrc" ]] ; then
    source "$HOME/.hostrc"
fi
