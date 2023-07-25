#!/bin/bash
set -eu

if [[ ! -d "$HOME/.rustup" ]] ; then
  curl -o "$HOME/rustup.sh" --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs
  sh rustup.sh --no-modify-path -y
  echo "rustup installed, reload shell to update PATH and re-run this script"
  exit 0
fi
rustup update
rustup upgrade
cargo install cargo-update
cargo install markdown2html-converter
cargo install --git https://github.com/kamiyaa/joshuto.git --force
cargo install-update -a

if [[ ! -d $HOME/bin/helix ]] ; then
  git clone https://github.com/helix-editor/helix "$HOME/bin/helix"
fi
(cd "$HOME/bin/helix" && git pull && cargo install --locked --path helix-term)
hx --grammar fetch
hx --grammar build

# Download and compile wezterm's terminfo database
curl -o "$HOME/.config/terminfo/wezterm.terminfo" https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo
tic -x -o "$HOME/.terminfo" "$HOME/.cache/wezterm.terminfo"

VVREPO=git@github.com:hackerb9/vv.git
CLONE_PATH=$HOME/bin/vv.git
if [[ ! -d $CLONE_PATH ]] ; then
  echo "Cloning $VVREPO"
  git clone $VVREPO "$CLONE_PATH"
fi
(cd "$CLONE_PATH" && git pull)
if [[ ! -e $HOME/bin/vv ]] ; then
  ln -s "$CLONE_PATH"/vv "$HOME/bin/vv"
fi

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
    --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# git clone --depth 1 https://github.com/wbthomason/packer.nvim \
#         ~/.local/share/nvim/site/pack/packer/start/packer.nvim
