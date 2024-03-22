#!/bin/bash
set -eu

if [[ ! -d "$HOME/.rustup" ]] ; then
  curl -o "$HOME/rustup.sh" --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs
  sh $HOME/rustup.sh --no-modify-path -y
  rm -f "$HOME/rustup.sh"
  echo "rustup installed, reload shell to update PATH and re-run this script"
  exit 0
fi
rustup update
rustup upgrade
# cargo install cargo-update
# cargo install markdown2html-converter
# cargo install-update -a

# Download and compile wezterm's terminfo database
curl -o "$HOME/.config/terminfo/wezterm.terminfo" https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo
tic -x -o "$HOME/.terminfo" "$HOME/.cache/wezterm.terminfo"

# pipx install titlecase

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
