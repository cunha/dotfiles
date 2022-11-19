#!/bin/bash
set -eu

if [[ ! -x $HOME/.cargo/bin/rustup ]] ; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
brew install exa
brew install ripgrep
brew install xsv

if [[ ! -d $HOME/bin/helix ]] ; then
  git clone https://github.com/helix-editor/helix "$HOME/bin/helix"
fi
(cd "$HOME/bin/helix" && git pull && cargo install --path helix-term)

