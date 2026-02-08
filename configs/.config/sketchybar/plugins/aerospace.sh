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
        sketchybar --set front_app label="" icon="" background.drawing=off
    else
        FOCUSED_APP=$(aerospace list-windows --workspace "$1" --focused 2>/dev/null | awk -F '|' '{gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}')
        if [ -n "$FOCUSED_APP" ]; then
            ICON=$($HOME/.config/sketchybar/plugins/icon_map_fn.sh "$FOCUSED_APP")
            sketchybar --set front_app label="$FOCUSED_APP" icon="$ICON" background.drawing=on
        else
            sketchybar --set front_app background.drawing=on
        fi
    fi
else
    sketchybar --set $NAME background.color=0xff45475a
fi
