#!/bin/bash
set -eu

sudo apt install pkg-config libssl-dev

DEBURL=https://github.com/wez/wezterm/releases/download/20230326-111934-3666303c/wezterm-20230326-111934-3666303c.Debian11.deb
DEBFILE=$HOME/.cache/$(basename $DEBURL)
if [[ ! -e $DEBFILE ]] ; then
	wget "$DEBURL" -O "$DEBFILE"
	sudo dpkg -i "$DEBFILE"
fi
