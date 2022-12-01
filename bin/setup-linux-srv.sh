#!/bin/bash
set -eu

DEBURL=https://github.com/wez/wezterm/releases/download/20221119-145034-49b9839f/wezterm-20221119-145034-49b9839f.Debian11.deb
DEBFILE=$HOME/.cache/$(basename $DEBURL)
if [[ ! -e $DEBFILE ]] ; then
	wget "$DEBURL" -O "$DEBFILE"
fi
sudo dpkg -i $DEBFILE
