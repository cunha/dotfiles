#!/bin/sh
set -eu

sleep 2s
xset dpms force off

# if [ ! -f $HOME/.cache/lcd-status ] ; then
#     echo 1 > $HOME/.cache/lcd-status
# fi

# read lcd < $HOME/.cache/lcd-status
# if [ "$lcd" -eq "0" ]; then
#     swaymsg "output * dpms on"
#     echo 1 > $HOME/.cache/lcd-status
# else
#     swaymsg "output * dpms off"
#     echo 0 > $HOME/.cache/lcd-status
# fi
