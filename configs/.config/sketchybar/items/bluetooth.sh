#!/bin/bash

sketchybar --add item bluetooth right \
           --set bluetooth update_freq=10 script="$PLUGIN_DIR/bluetooth.sh" \
                           background.color=$BLUE \
                           background.corner_radius=5 \
                           background.height=24 \
                           background.padding_left=10 \
                           background.padding_right=6 \
                           background.drawing=on \
                           background.border_width=1 \
                           background.border_color=$BORDER_COLOR \
                           label.color=$DARK_TEXT \
                           icon.color=$DARK_TEXT \
                           padding_left=0 padding_right=8 \
