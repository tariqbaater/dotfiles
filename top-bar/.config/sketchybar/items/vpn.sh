#!/bin/bash

# Main VPN item with popup
sketchybar --add item vpn left \
           --set vpn update_freq=10 script="$PLUGIN_DIR/vpn.sh" \
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
                     padding_left=5 \
                     popup.align=left \
                     popup.background.color=$POPUP_BG \
                     popup.background.corner_radius=8 \
                     popup.background.border_width=1 \
                     popup.background.border_color=$BORDER_COLOR \
                     click_script='sketchybar --set vpn popup.drawing=toggle' \
           --subscribe vpn vpn_change

# VPN popup menu items
sketchybar --add item vpn.connect popup.vpn \
           --set vpn.connect icon=􀢔 label="Connect" \
                             icon.color=$GREEN label.color=$TEXT \
                             click_script="$CONFIG_DIR/plugins/vpn_action.sh connect" \
                             background.corner_radius=4 \
                             padding_left=10 padding_right=10 \
                             background.height=28

sketchybar --add item vpn.disconnect popup.vpn \
           --set vpn.disconnect icon=􀌔 label="Disconnect" \
                                icon.color=$RED label.color=$TEXT \
                                click_script="$CONFIG_DIR/plugins/vpn_action.sh disconnect" \
                                background.corner_radius=4 \
                                padding_left=10 padding_right=10 \
                                background.height=28

sketchybar --add item vpn.open_app popup.vpn \
           --set vpn.open_app icon=􁅏 label="OpenVPN" \
                              icon.color=$BLUE label.color=$TEXT \
                              click_script="open -b org.openvpn.client.app; sketchybar --set vpn popup.drawing=off" \
                              background.corner_radius=4 \
                              padding_left=10 padding_right=10 \
                              background.height=28
