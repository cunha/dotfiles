if [[ ! -d "$HOME"/.nvm ]] ; then
  PROFILE=/dev/null curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
fi
nvm install --lts
nvm use --lts
npm install --location=global bash-language-server
npm upgrade --location=global bash-language-server

