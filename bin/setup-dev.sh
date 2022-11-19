#!/bin/bash
set -eu

brew install bash-language-server
brew install shellcheck

brew install lua-language-server

# install python language server

pip3 install --user --upgrade pip
AUTO_VENV_REPO="https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git"
CLONE_PATH=$HOME/bin/zsh-autoswitch-virtualenv
if [[ ! -d $CLONE_PATH ]] ; then
  git clone $AUTO_VENV_REPO "$CLONE_PATH"
fi
(cd "$CLONE_PATH" && git pull)

