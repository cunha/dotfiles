#!/bin/bash
set -eu

# xcode-select --install
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# brew install --cask amethyst
brew install atool
brew install bash
brew install coreutils
brew install curl
brew install --cask docker
brew install fzf
brew install git
brew install gnu-sed
brew install iproute2mac
brew install jq
brew install man-db
brew install --cask marta
brew install pandoc
brew install showkey
brew install --cask skim
brew install socat
brew install tectonic
brew install texlive
brew install tmux
brew install unzip
brew install w3m
brew install --cask wezterm --no-quarantine
brew install wget
brew install --cask zoom

brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono
brew install --cask font-symbols-only-nerd-font
brew install --cask font-noto-color-emoji

ln -s /Applications/Marta.app/Contents/Resources/launcher "$HOME/bin/marta"
