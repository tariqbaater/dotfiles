#!/bin/sh

# Simple WiFi status check
WIFI_STATUS=$(ifconfig en0 2>/dev/null | grep "status:" | awk '{print $2}')

if [ "$WIFI_STATUS" = "active" ]; then
  ICON="󰤨"
else
  ICON="󰤭"
fi

sketchybar --set "$NAME" icon="$ICON" label=""
