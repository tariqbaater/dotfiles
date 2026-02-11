#!/bin/sh
source "$HOME/.config/sketchybar/colors.sh"

# Check if OpenVPN Connect app is running
VPN_RUNNING=$(pgrep -f "OpenVPN Connect" 2>/dev/null)

if [ -z "$VPN_RUNNING" ]; then
  ICON="􁣡"
  LABEL="VPN Off"
else
  # Detect which interface handles public traffic
  VPN_IF=$(route get 1.1.1.1 2>/dev/null | awk '/interface:/ {print $2}')

  if echo "$VPN_IF" | grep -q "^utun"; then
    ICON="􁅏"
    LABEL="VPN On"
  else
    ICON="􁣡"
    LABEL="VPN Off"
  fi
fi

# Catppuccin Mocha: Red=#f38ba8, Green=#a6e3a1
if [ "$LABEL" = "VPN On" ]; then
  BG_COLOR=$GREEN
else
  BG_COLOR=$RED
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL" background.color="$BG_COLOR"
