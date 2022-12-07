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
cargo install exa
cargo install ripgrep
cargo install xsv
cargo install-update -a

if [[ ! -d $HOME/bin/helix ]] ; then
  git clone https://github.com/helix-editor/helix "$HOME/bin/helix"
fi
(cd "$HOME/bin/helix" && git pull && cargo install --path helix-term)
hx --grammar fetch
hx --grammar build

# Download and compile wezterm's terminfo database
curl -o "$HOME/.cache/wezterm.terminfo" https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo
tic -x -o "$HOME/.terminfo" "$HOME/.cache/wezterm.terminfo"

