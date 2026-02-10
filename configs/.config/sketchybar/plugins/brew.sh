#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

case "$SENDER" in
"mouse.clicked")
  open -a ghostty "$CONFIG_DIR/plugins/brew_update.sh"
  ;;
*)
  COUNT=$(brew outdated 2>/dev/null | wc -l | tr -d ' ')

  if [ "$COUNT" -gt 0 ] 2>/dev/null; then
    sketchybar --set "$NAME" label="$COUNT" label.drawing=on
  else
    sketchybar --set "$NAME" label.drawing=off
  fi
  ;;
esac


