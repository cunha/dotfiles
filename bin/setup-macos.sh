#!/bin/bash
set -eu

xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install atool
brew install bash
brew install coreutils
brew install curl
brew install fzf
brew install git
brew install gnu-sed
brew install jq
brew install man-db
brew install mupdf
brew install showkey
brew install skim
brew install socat
brew install tectonic
brew install texlive
brew install tmux
brew install unzip
brew install w3m
brew install wezterm
brew install wget

