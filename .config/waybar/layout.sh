#!/bin/sh
# This file adapted from gagbo
# https://framagit.org/gagbo/dotfiles/-/blob/master/sway/.config/waybar/layout.sh

swaymsg --type get_inputs \
    | jq --raw-output \
        '.[] | select(.type == "keyboard") | .xkb_active_layout_index' \
    | sed --unbuffered 's/0/us/;s/1/br/'

swaymsg --type subscribe --monitor --raw '["input"]' \
    | jq --raw-output --unbuffered \
        'select(.change == "xkb_layout") | .input.xkb_active_layout_index' \
    | sed --unbuffered 's/0/us/;s/1/br/'
