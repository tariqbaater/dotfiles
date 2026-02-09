#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

source "$HOME/.config/sketchybar/colors.sh"

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
CURRENT_FILE="/tmp/sketchybar_current_workspace"
PREV_FILE="/tmp/sketchybar_prev_workspace"

# Track previous workspace
STORED_CURRENT=""
[ -f "$CURRENT_FILE" ] && STORED_CURRENT=$(cat "$CURRENT_FILE")

if [ "$FOCUSED_WORKSPACE" != "$STORED_CURRENT" ]; then
    [ -n "$STORED_CURRENT" ] && echo "$STORED_CURRENT" > "$PREV_FILE"
    echo "$FOCUSED_WORKSPACE" > "$CURRENT_FILE"
fi

PREV_WORKSPACE=""
[ -f "$PREV_FILE" ] && PREV_WORKSPACE=$(cat "$PREV_FILE")

# Only show current and previous workspace
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.color=$ACCENT_COLOR drawing=on

    # Clear front_app if focused workspace has no windows
    WINDOW_COUNT=$(aerospace list-windows --workspace "$1" 2>/dev/null | wc -l | tr -d ' ')
    if [ "$WINDOW_COUNT" -eq 0 ]; then
        sketchybar --set front_app label="" icon="" background.drawing=off
    else
        FOCUSED_APP=$(aerospace list-windows --workspace "$1" --focused 2>/dev/null | awk -F '|' '{gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}')
        # Fallback: if --focused returns nothing (timing race), get any window from workspace
        if [ -z "$FOCUSED_APP" ]; then
            FOCUSED_APP=$(aerospace list-windows --workspace "$1" 2>/dev/null | head -1 | awk -F '|' '{gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}')
        fi
        if [ -n "$FOCUSED_APP" ]; then
            ICON=$($HOME/.config/sketchybar/plugins/icon_map_fn.sh "$FOCUSED_APP")
            sketchybar --set front_app label="$FOCUSED_APP" icon="$ICON" background.drawing=on
        else
            sketchybar --set front_app label="" icon="" background.drawing=off
        fi
    fi
elif [ "$1" = "$PREV_WORKSPACE" ]; then
    sketchybar --set $NAME background.color=0xff45475a drawing=on
else
    sketchybar --set $NAME drawing=off
fi
