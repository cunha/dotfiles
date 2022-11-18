#!/bin/sh
set -u

setxkbmap -query | grep intl > /dev/null
if [ $? -eq 0 ] ; then
    setxkbmap -option
    setxkbmap -layout uscunha -option shift:both_capslock
    rm -f .cache/us-intl
    pkill -USR1 i3status
else
    setxkbmap -option
    setxkbmap -layout uscunha -variant alt-intl -option shift:both_capslock
    touch .cache/us-intl
    pkill -USR1 i3status
fi
