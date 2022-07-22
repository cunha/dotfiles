#!/bin/bash

git clone https://github.com/helix-editor/helix "$HOME/bin/helix"
(cd "$HOME/bin/helix" && git pull && cargo install --path helix-term)

