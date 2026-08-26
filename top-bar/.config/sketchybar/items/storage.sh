#!/bin/bash

# Main Storage item with popup
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
                         script="$PLUGIN_DIR/storage.sh" \
                         popup.align=left \
                         popup.background.color=$POPUP_BG \
                         popup.background.corner_radius=8 \
                         popup.background.border_width=1 \
                         popup.background.border_color=$BORDER_COLOR \
                         click_script='sketchybar --set storage popup.drawing=toggle' \
           --subscribe storage system_woke

# Storage popup menu items
sketchybar --add item storage.settings popup.storage \
           --set storage.settings icon=􀣋 label="Storage Settings" \
                                  icon.color=$SAPPHIRE label.color=$TEXT \
                                  click_script="open 'x-apple.systempreferences:com.apple.settings.Storage'; sketchybar --set storage popup.drawing=off" \
                                  background.corner_radius=4 \
                                  padding_left=10 padding_right=10 \
                                  background.height=28

sketchybar --add item storage.disk_util popup.storage \
           --set storage.disk_util icon=􀤶 label="Disk Utility" \
                                      icon.color=$SAPPHIRE label.color=$TEXT \
                                      click_script="open -a 'Disk Utility'; sketchybar --set storage popup.drawing=off" \
                                      background.corner_radius=4 \
                                      padding_left=10 padding_right=10 \
                                      background.height=28

sketchybar --add item storage.terminal popup.storage \
           --set storage.terminal icon=􀱅 label="Open in Terminal" \
                                  icon.color=$SAPPHIRE label.color=$TEXT \
                                  click_script="$CONFIG_DIR/plugins/storage_terminal.sh; sketchybar --set storage popup.drawing=off" \
                                  background.corner_radius=4 \
                                  padding_left=10 padding_right=10 \
                                  background.height=28
