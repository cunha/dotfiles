#!/bin/bash
set -eu

xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
 
brew install bash
brew install git
brew install jq
brew install lazygit
brew install openvpn
brew install neovim
brew install showkey
brew install socat
brew install tmux
brew install unzip
brew install wezterm
brew install wget
