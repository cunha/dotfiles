#!/bin/bash
set -eu

# xcode-select --install
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

mkdir -p $HOME/.logs

brew install atool \
             ansible \
             bash \
             coreutils \
             curl \
             git \
             gnu-sed \
             iproute2mac \
             jq \
             man-db \
             media-info \
             openjdk \
             ossp-uuid \
             pandoc \
             pipx \
             showkey \
             socat \
             tectonic \
             telnet \
             texlab \
             texlive \
             tmux \
             transmission-cli \
             unzip \
             visual-studio-code \
             websocat \
             w3m \
             wget \
             yq

brew install --cask battery \
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
brew install --cask kitty --no-quarantine

brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono \
                    font-symbols-only-nerd-font \
                    font-noto-color-emoji

# ln -s /Applications/Marta.app/Contents/Resources/launcher "$HOME/bin/marta"

echo "Setting up dark-mode-notify"
mkdir -p $HOME/.logs
DMNDIR=$HOME/.cache/dark-mode-notify.git
if [[ ! -d $DMNDIR ]] ; then
	git clone https://github.com/bouk/dark-mode-notify.git $DMNDIR
fi
pushd $HOME/.cache/dark-mode-notify.git &> /dev/null
git pull
make
cp .build/release/dark-mode-notify $HOME/bin/
popd &> /dev/null
cp $HOME/.config/dark-mode-notify/ke.bou.dark-mode-notify.plist ~/Library/LaunchAgents/
launchctl load -w /Users/cunha/Library/LaunchAgents/ke.bou.dark-mode-notify.plist
