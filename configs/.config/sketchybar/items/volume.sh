#!/bin/bash

sketchybar --add item volume right \
           --set volume script="$PLUGIN_DIR/volume.sh" \
                        background.color=$PINK \
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
                        click_script="open 'x-apple.systempreferences:com.apple.preference.sound'" \
           --subscribe volume volume_change \
