#!/bin/bash
set -eu

sudo apt install pkg-config libssl-dev

# DEBURL=https://github.com/wez/wezterm/releases/download/20221119-145034-49b9839f/wezterm-20221119-145034-49b9839f.Debian11.deb
# DEBFILE=$HOME/.cache/$(basename $DEBURL)
# if [[ ! -e $DEBFILE ]] ; then
# 	wget "$DEBURL" -O "$DEBFILE"
# 	sudo dpkg -i "$DEBFILE"
# fi
