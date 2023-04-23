#!/bin/bash
set -eu

sudo apt install pkg-config libssl-dev

DEBURL=https://github.com/wez/wezterm/releases/download/20230408-112425-69ae8472/wezterm-20230408-112425-69ae8472.Debian11.deb
DEBFILE=$HOME/.cache/$(basename $DEBURL)
if [[ ! -e $DEBFILE ]] ; then
	wget "$DEBURL" -O "$DEBFILE"
	sudo dpkg -i "$DEBFILE"
fi
