xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
 
brew install git
brew install jq
brew install neovim
brew install showkey
brew install tmux
brew install unzip
brew install wezterm

# Download and compile wezterm's terminfo database
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-update
cargo install exa
cargo install ripgrep
cargo install xsv
