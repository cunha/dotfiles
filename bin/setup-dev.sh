#!/bin/bash
set -eu

# setup-hx.sh
# setup-nv.sh

PROFILE=/dev/null curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
nvm install --lts
nvm use --lts
npm install --location=global bash-language-server
npm upgrade --location=global bash-language-server

# install python language server
# install julia

pip3 install --user --upgrade pip

AUTO_VENV_REPO="https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git"
CLONE_PATH=$HOME/bin/zsh-autoswitch-virtualenv
if [[ ! -d $CLONE_PATH ]] ; then
  git clone $AUTO_VENV_REPO $CLONE_PATH
fi
(cd $CLONE_PATH && git pull)

