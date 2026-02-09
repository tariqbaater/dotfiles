#!/bin/bash

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        background.color=$SURFACE_COLOR \
        background.corner_radius=5 \
        background.height=24 \
        background.padding_left=2 \
        background.padding_right=2 \
        padding_left=3 \
        padding_right=3 \
        background.drawing=on \
        background.border_width=1 \
        background.border_color=$BORDER_COLOR \
        drawing=off \
        label="$sid" \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done
