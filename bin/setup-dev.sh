#!/bin/bash
set -eu

# setup-hx.sh
# setup-nv.sh

function setup_bash_language_server {
    export PROFILE=/dev/null
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    unset PROFILE
    npm install --location=global bash-language-server
    npm upgrade --location=global bash-language-server
}

# install python language server
# install julia

setup_bash_language_server
