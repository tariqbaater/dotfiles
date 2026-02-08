#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

source "$HOME/.config/sketchybar/colors.sh"

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.color=$ACCENT_COLOR
else
    sketchybar --set $NAME background.color=0xff45475a
fi
