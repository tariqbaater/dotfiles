#!/bin/bash

sketchybar --add item wifi right \
           --set wifi update_freq=10 script="$PLUGIN_DIR/wifi.sh" \
                      background.color=$PEACH \
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
                      click_script="open 'x-apple.systempreferences:com.apple.preference.network'" \
           --subscribe wifi wifi_change
