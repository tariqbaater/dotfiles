#!/bin/bash

sketchybar --add item battery right \
           --set battery update_freq=120 script="$PLUGIN_DIR/battery.sh" \
                         background.color=$TEAL \
                         background.corner_radius=5 \
                         background.height=24 \
                         background.padding_left=6 \
                         background.padding_right=10 \
                         background.drawing=on \
                         background.border_width=1 \
                         background.border_color=$BORDER_COLOR \
                         label.color=$DARK_TEXT \
                         icon.color=$DARK_TEXT \
                         padding_left=0 padding_right=8 \
           --subscribe battery system_woke power_source_change \
