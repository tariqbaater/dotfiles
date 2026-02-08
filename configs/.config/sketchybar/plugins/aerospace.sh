#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

source "$HOME/.config/sketchybar/colors.sh"

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.color=$ACCENT_COLOR

    # Clear front_app if focused workspace has no windows
    WINDOW_COUNT=$(aerospace list-windows --workspace "$1" 2>/dev/null | wc -l | tr -d ' ')
    if [ "$WINDOW_COUNT" -eq 0 ]; then
        sketchybar --set front_app label="" background.drawing=off
    else
        sketchybar --set front_app background.drawing=on
    fi
else
    sketchybar --set $NAME background.color=0xff45475a
fi
