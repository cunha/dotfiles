#!/usr/bin/env bash
set -eu

KITTY=/opt/homebrew/bin/kitty
KITTYCFGDIR=$HOME/.config/kitty/

echo "dark-mode-notify running $(date +%Y%m%d-%H%M%S)"
echo "DARKMODE=$DARKMODE"

if [[ $DARKMODE -eq 0 ]] ; then
	# $KITTY kitten @ set-colors --all $KITTYCFGDIR/themes/AyuLight.conf
	$KITTY kitten themes --reload-in all Ayu Light
	cp $KITTYCFGDIR/themes/AyuLight.conf $KITTYCFGDIR/current-theme.conf
else
	# $KITTY kitten @ set-colors --all $KITTYCFGDIR/themes/Azureus.conf
	$KITTY kitten themes --reload-in all Azureus
	cp $KITTYCFGDIR/themes/Azureus.conf $KITTYCFGDIR/current-theme.conf
fi
