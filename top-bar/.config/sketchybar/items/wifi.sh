#!/bin/bash

# Main WiFi item with popup
sketchybar --add item wifi right \
           --set wifi update_freq=10 script="$PLUGIN_DIR/wifi.sh" \
                      background.color=$BLUE \
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
                      popup.align=right \
                      popup.background.color=$POPUP_BG \
                      popup.background.corner_radius=8 \
                      popup.background.border_width=1 \
                      popup.background.border_color=$BORDER_COLOR \
                      click_script="$CONFIG_DIR/plugins/wifi_menu.sh" \
           --subscribe wifi wifi_change
