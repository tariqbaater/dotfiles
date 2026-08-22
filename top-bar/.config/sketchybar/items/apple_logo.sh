#!/bin/bash

sketchybar --add item apple_logo left \
           --set apple_logo icon=􀣺 label.drawing=off \
                            icon.font="SF Pro:Semibold:18.0" \
                            icon.padding_left=10 \
                            icon.padding_right=10 \
                            background.color=$SURFACE_COLOR \
                            background.corner_radius=5 \
                            background.height=24 \
                            background.drawing=on \
                            background.border_width=1 \
                            background.border_color=$BORDER_COLOR \
                            padding_left=4 \
                            padding_right=4 \
                            click_script="open -b com.apple.systempreferences" \
