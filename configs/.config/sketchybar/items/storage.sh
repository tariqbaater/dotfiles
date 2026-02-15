#!/bin/bash

sketchybar --add item storage left \
           --set storage update_freq=300 \
                         icon=􀥾 \
                         background.color=$SAPPHIRE \
                         background.corner_radius=5 \
                         background.height=24 \
                         background.padding_left=6 \
                         background.padding_right=10 \
                         background.drawing=on \
                         background.border_width=1 \
                         background.border_color=$BORDER_COLOR \
                         label.color=$DARK_TEXT \
                         icon.color=$DARK_TEXT \
                         icon.font="SF Pro:Semibold:16.0" \
                         padding_left=5 \
                         script="$PLUGIN_DIR/storage.sh"
