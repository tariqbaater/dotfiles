#!/bin/bash

sketchybar --add item clock right \
           --set clock update_freq=10 \
                       background.color=$GREEN \
                       background.corner_radius=5 \
                       background.height=24 \
                       background.padding_left=10 \
                       background.padding_right=10 \
                       background.drawing=on \
                       background.border_width=1 \
                       background.border_color=$BORDER_COLOR \
                       label.color=$DARK_TEXT \
                       icon.color=$DARK_TEXT \
                       padding_left=0 padding_right=8 \
                       script="$PLUGIN_DIR/clock.sh" \
                       click_script="open -b com.apple.iCal"
