#!/bin/bash

sketchybar --add item brew left \
           --set brew update_freq=300 \
                      icon=􁞴 \
                      background.color=$YELLOW \
                      background.corner_radius=5 \
                      background.height=24 \
                      background.padding_left=6 \
                      background.padding_right=10 \
                      background.drawing=on \
                      background.border_width=1 \
                      background.border_color=$BORDER_COLOR \
                      label.color=$DARK_TEXT \
                      icon.color=$DARK_TEXT \
                      padding_left=5 \
                      script="$PLUGIN_DIR/brew.sh" \
           --subscribe brew mouse.clicked
