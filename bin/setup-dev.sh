#!/bin/zsh
set -eu

KERNEL=$(uname -s)
KERNELLOW=$(uname -s | tr '[:upper:]' '[:lower:]')
MARCH=$(uname -m)
MARCHS=${MARCH//86_/}

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

cargo install --git https://github.com/astral-sh/rye rye
cargo install taplo-cli --locked --features lsp
cargo install-update -a

# brew install bash-language-server \
#     exa \
#     helix \
#     joshuto \
#     lazygit \
#     lua-language-server \
#     neovim \
#     python \
#     ripgrep \
#     shellcheck \
#     taplo \
#     texlab \
#     vscode-langservers-extracted \
#     xsv \
#     yaml-language-server \
#     zellij
