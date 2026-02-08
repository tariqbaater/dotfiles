#!/bin/sh

# Check if OpenVPN Connect app is running
VPN_RUNNING=$(pgrep -f "OpenVPN Connect" 2>/dev/null)

if [ -z "$VPN_RUNNING" ]; then
  ICON="󰌾"
  LABEL="VPN Off"
else
  # Check if actually connected by looking for tun interface
  TUN_INTERFACE=$(ifconfig | grep -o "utun9" | head -1)
  if [ -n "$TUN_INTERFACE" ]; then
    ICON="󰿆"
    LABEL="VPN On"
  else
    ICON="󰌾"
    LABEL="VPN Off"
  fi
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
