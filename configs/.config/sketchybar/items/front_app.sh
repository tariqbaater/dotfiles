#!/bin/bash

sketchybar --add item chevron left \
           --set chevron icon=􁍃 label.drawing=off \
           --add item front_app left \
           --set front_app icon.drawing=on \
                           icon.font="sketchybar-app-font:Regular:16.0" \
                           script="$PLUGIN_DIR/front_app.sh" \
                           background.color=$MAUVE \
                           background.corner_radius=5 \
                           background.height=24 \
                           background.padding_left=10 \
                           background.padding_right=10 \
                           background.drawing=on \
                           background.border_width=1 \
                           background.border_color=$BORDER_COLOR \
                           label.color=$DARK_TEXT \
                           icon.color=$DARK_TEXT \
           --subscribe front_app front_app_switched
