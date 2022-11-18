#!/bin/sh
set -eu

if [[ ! -x $HOME/.cargo/bin/rustup ]] ; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
cargo install cargo-update
cargo install exa
cargo install ripgrep
cargo install xsv
cargo install-update -a

if [[ ! -d $HOME/bin/helix ]] ; then
  git clone https://github.com/helix-editor/helix "$HOME/bin/helix"
fi
(cd "$HOME/bin/helix" && git pull && cargo install --path helix-term)

