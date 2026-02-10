#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

# Required: brew crashes in sketchybar's launchd sandbox without this
# (Hardware::CPU.cores fails when getconf can't spawn as a subprocess)
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_DOWNLOAD_CONCURRENCY=4

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


