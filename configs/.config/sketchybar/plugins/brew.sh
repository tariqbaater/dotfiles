#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

BREW="/opt/homebrew/bin/brew"

# Ensure brew and its dependencies are in PATH inside sketchybar's sandbox
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Required: brew crashes in sketchybar's launchd sandbox without this
# (Hardware::CPU.cores fails when getconf can't spawn as a subprocess)
# export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_DOWNLOAD_CONCURRENCY=1

case "$SENDER" in
"mouse.clicked")
  open -a Terminal "$CONFIG_DIR/plugins/brew_update.sh"
  ;;
*)
  COUNT=$($BREW outdated 2>/dev/null | wc -l | tr -d ' ')

  if [ "$COUNT" -gt 0 ] 2>/dev/null; then
    sketchybar --set "$NAME" label="$COUNT" label.drawing=on
  else
    sketchybar --set "$NAME" label.drawing=off
  fi
  ;;
esac


