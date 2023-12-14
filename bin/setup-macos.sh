#!/bin/bash
set -eu

# xcode-select --install
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install atool \
             ansible \
             bash \
             coreutils \
             curl \
             fzf \
             git \
             gnu-sed \
             iproute2mac \
             jq \
             man-db \
             media-info \
             openjdk \
             ossp-uuid \
             pandoc \
             showkey \
             socat \
             tectonic \
             telnet \
             texlive \
             tmux \
             transmission-cli \
             unzip \
             visual-studio-code \
             websocat \
             w3m \
             wget

brew install --cask aldente \
                    discord \
                    docker \
                    firefox \
                    google-chrome \
                    google-drive \
                    hammerspoon \
                    karabiner-elements \
                    keepassxc \
                    libreoffice \
                    linearmouse \
                    maccy \
                    marta \
                    microsoft-office \
                    slack \
                    wireshark \
                    skim \
                    transmission \
                    transmission-remote-gui \
                    utm \
                    visual-studio-code \
                    vlc \
                    zoom \
                    # amethyst
                    # webex

brew install --cask wezterm --no-quarantine

brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono \
                    font-symbols-only-nerd-font \
                    font-noto-color-emoji

ln -s /Applications/Marta.app/Contents/Resources/launcher "$HOME/bin/marta"
