#!/bin/bash
set -eu

brew install bash-language-server
brew install shellcheck

brew install lua-language-server

pip3 install --user --upgrade pip
pip3 install --upgrade black
pip3 install --upgrade pyflakes
pip3 install --upgrade python-lsp-server
pip3 install --upgrade rope

AUTO_VENV_REPO="https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git"
CLONE_PATH=$HOME/bin/zsh-autoswitch-virtualenv
if [[ ! -d $CLONE_PATH ]] ; then
  git clone $AUTO_VENV_REPO "$CLONE_PATH"
fi
(cd "$CLONE_PATH" && git pull)

