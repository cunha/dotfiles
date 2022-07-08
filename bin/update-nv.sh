#!/bin/sh
set -eu

curl -fLo "$HOME/bin/nv" \
    https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod 755 $HOME/bin/nv

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
    --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
