#!/bin/sh

# Check if OpenVPN Connect app is running
VPN_RUNNING=$(pgrep -f "OpenVPN Connect" 2>/dev/null)

if [ -z "$VPN_RUNNING" ]; then
  ICON="􁣡"
  LABEL="VPN Off"
else
  # Check if actually connected by looking for tun interface
  TUN_INTERFACE=$(ifconfig | grep -o "utun9" | head -1)
  if [ -n "$TUN_INTERFACE" ]; then
    ICON="􁅏"
    LABEL="VPN On"
  else
    ICON="􁣡"
    LABEL="VPN Off"
  fi
fi

# Catppuccin Mocha: Red=#f38ba8, Green=#a6e3a1
if [ "$LABEL" = "VPN On" ]; then
  BG_COLOR="0xffa6e3a1"
else
  BG_COLOR="0xfff38ba8"
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL" background.color="$BG_COLOR"
