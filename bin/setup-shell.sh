#!/bin/bash
set -eu

# KERNEL=$(uname -s)
# KERNELLOW=$(uname -s | tr '[:upper:]' '[:lower:]')
# MARCH=$(uname -m)
# MARCHS=${MARCH//86_/}

if [[ ! -d "$HOME/.rustup" ]] ; then
  curl -o "$HOME/rustup.sh" --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs
  sh "$HOME/rustup.sh" --no-modify-path -y
  rm -f "$HOME/rustup.sh"
  echo "rustup installed, reload shell to update PATH and re-run this script"
  exit 0
fi
rustup update
rustup upgrade

cargo install cargo-update
cargo install markdown2html-converter
cargo install-update -a

# On Debian, this requires that we are in the nix-users group.
if ! nix-channel --list | grep -F nixpkgs &> /dev/null ; then
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
fi
nix-channel --update
nix-env -iA nixpkgs.ansible-language-server
nix-env -iA nixpkgs.atuin
nix-env -iA nixpkgs.bash-language-server
nix-env -iA nixpkgs.helix
nix-env -iA nixpkgs.fzf
nix-env -iA nixpkgs.joshuto
nix-env -iA nixpkgs.lazygit
nix-env -iA nixpkgs.lua-language-server
nix-env -iA nixpkgs.ltex-ls
nix-env -iA nixpkgs.miniserve
nix-env -iA nixpkgs.mods
nix-env -iA nixpkgs.ripgrep
nix-env -iA nixpkgs.rye
nix-env -iA nixpkgs.shellcheck
nix-env -iA nixpkgs.taplo
nix-env -iA nixpkgs.xsv
nix-env -iA nixpkgs.yaml-language-server
nix-env -iA nixpkgs.zellij
nix-env -iA nixpkgs.zoxide

AUTO_VENV_REPO="https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git"
CLONE_PATH=$HOME/bin/zsh-autoswitch-virtualenv
if [[ ! -d $CLONE_PATH ]] ; then
  echo "Cloning $AUTO_VENV_REPO"
  git clone $AUTO_VENV_REPO "$CLONE_PATH"
fi
(cd "$CLONE_PATH" && git pull)

pipx install python-lsp-server
pipx install ruff-lsp
pipx install titlecase
pipx upgrade-all

# mkdir -p $HOME/git
# if [[ ! -d $HOME/git/helix ]] ; then
#   git clone https://github.com/helix-editor/helix.git $HOME/git/helix
# fi
# cd $HOME/git/helix && git pull && cargo install --path helix-term --locked

# Download and compile wezterm's terminfo database
# curl -o "$HOME/.config/terminfo/wezterm.terminfo" https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo
# tic -x -o "$HOME/.terminfo" "$HOME/.cache/wezterm.terminfo"

# VVREPO=git@github.com:hackerb9/vv.git
# CLONE_PATH=$HOME/bin/vv.git
# if [[ ! -d $CLONE_PATH ]] ; then
#   echo "Cloning $VVREPO"
#   git clone $VVREPO "$CLONE_PATH"
# fi
# (cd "$CLONE_PATH" && git pull)
# if [[ ! -e $HOME/bin/vv ]] ; then
#   ln -s "$CLONE_PATH"/vv "$HOME/bin/vv"
# fi

# curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
#     --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# mkdir -p $HOME/.vim/plugins
# cd $HOME/.vim/plugins
# if [[ -d dein.vim ]] ; then
#     cd dein.vim && git pull
# else
#     git clone git@github.com:Shougo/dein.vim.git dein.vim
# fi


if [[ ! -d $HOME/bin/peering-shell ]] ; then
  git clone git@github.com:PEERINGTestbed/peering-shell.git "$HOME/bin/peering-shell"
  ln -s "$HOME/bin/peering-shell/peering" "$HOME/bin/peering"
fi
(cd "$HOME/bin/peering-shell" && git pull)

echo "Setup completed successfully"
