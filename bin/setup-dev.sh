#!/bin/zsh
set -eu

KERNEL=$(uname -s)
KERNELLOW=$(uname -s | tr '[:upper:]' '[:lower:]')
MARCH=$(uname -m)
MARCHS=${MARCH//86_/}

# if [[ $KERNEL == Linux ]] ; then
#   if [[ ! -x $HOME/.cargo/bin/fnm ]] ; then
#     cargo install fnm
#     fnm install --lts
#     echo "fnm installed, please re-open the shell and rerun this script" && exit 0
#   fi
#   npm install --location=global bash-language-server
#   sudo aptitude install shellcheck
# elif [[ $KERNEL == Darwin ]] ; then

brew install bash-language-server
brew install exa
brew install helix
brew install joshuto
brew install lazygit
brew install lua-language-server
brew install neovim
brew install python
brew install ripgrep
brew install shellcheck
brew install taplo
brew install texlab
brew install virtualenv
brew install vscode-langservers-extracted
brew install xsv
brew install yaml-language-server

pip3 install --user --upgrade -r $HOME/.config/requirements.txt

AUTO_VENV_REPO="https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git"
CLONE_PATH=$HOME/bin/zsh-autoswitch-virtualenv
if [[ ! -d $CLONE_PATH ]] ; then
  echo "Cloning $AUTO_VENV_REPO"
  git clone $AUTO_VENV_REPO "$CLONE_PATH"
fi
(cd "$CLONE_PATH" && git pull)

# LUAVER=$(curl -s "https://api.github.com/repos/sumneko/lua-language-server/releases/latest" | grep '"tag_name":' | sed -E 's/.*tag_name": "(.*[^"]+)".*/\1/')
# LUAURL="https://github.com/sumneko/lua-language-server/releases/latest/download/lua-language-server-${LUAVER}-${KERNELLOW}-${MARCHS}.tar.gz"
# LUAFILE=$HOME/.cache/$(basename "$LUAURL")
# if [[ ! -e "$LUAFILE" ]] ; then
#   echo "Grabbing lua-language-server $LUAVER"
#   curl -Lo "$LUAFILE" "$LUAURL"
# fi
# mkdir -p "$HOME/bin/lua-ls"
# tar xf "$LUAFILE" --directory "$HOME/bin/lua-ls"
# ln -s "$HOME/.local/bin/lua-language-server" "$HOME/bin/lua-ls/bin/lua-language-server"

# LGVER=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
# echo "Grabbing lazygit $LGVER"
# LGURL="https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LGVER}_${KERNEL}_${MARCH}.tar.gz"
# LGFILE=$(basename "$LGURL")
# if [[ ! -e "$LGFILE" ]] ; then
#   curl -Lo "$LGFILE" "$LGURL"
# fi
# tar xf "$LGFILE" --directory "$HOME/bin" lazygit
