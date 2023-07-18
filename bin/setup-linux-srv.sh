#!/bin/bash
set -eu

sudo apt install pkg-config libssl-dev

DEBURL=https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/wezterm-20230712-072601-f4abf8fd.Debian11.deb
DEBFILE=$HOME/.cache/$(basename $DEBURL)
if [[ ! -e $DEBFILE ]] ; then
	wget "$DEBURL" -O "$DEBFILE"
	sudo dpkg -i "$DEBFILE"
fi
