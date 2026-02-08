#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

ICON="􀧞"

sketchybar --set "$NAME" icon=$ICON label="$(date '+%a %b %-d %-H:%M')"

