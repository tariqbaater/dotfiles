#!/bin/sh
source "$HOME/.config/sketchybar/colors.sh"

# Check if OpenVPN Connect app is running
VPN_RUNNING=$(pgrep -f "OpenVPN Connect" 2>/dev/null)

if [ -z "$VPN_RUNNING" ]; then
  ICON="􁣡"
  LABEL="VPN Off"
  CONNECTED=false
else
  # Detect which interface handles public traffic
  VPN_IF=$(route get 1.1.1.1 2>/dev/null | awk '/interface:/ {print $2}')

  if echo "$VPN_IF" | grep -q "^utun"; then
    ICON="􁅏"
    LABEL="VPN On"
    CONNECTED=true
  else
    ICON="􁣡"
    LABEL="VPN Off"
    CONNECTED=false
  fi
fi

# Catppuccin Mocha: Red=#f38ba8, Green=#a6e3a1
if [ "$LABEL" = "VPN On" ]; then
  BG_COLOR=$GREEN
else
  BG_COLOR=$RED
fi

# Update popup items based on connection state
if [ "$CONNECTED" = true ]; then
  sketchybar --set vpn.connect drawing=off \
             --set vpn.disconnect drawing=on
else
  sketchybar --set vpn.connect drawing=on \
             --set vpn.disconnect drawing=off
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL" background.color="$BG_COLOR"
