#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_DOWNLOAD_CONCURRENCY=4

case "$SENDER" in
"mouse.clicked")
  open -a Terminal "$CONFIG_DIR/plugins/brew_update.sh"
  ;;
*)
  COUNT=$(brew outdated 2>/dev/null | grep -c .)

  if [ "$COUNT" -gt 0 ]; then
    sketchybar --set "$NAME" label="$COUNT" label.drawing=on
  else
    sketchybar --set "$NAME" label.drawing=off
  fi
  ;;
esac
