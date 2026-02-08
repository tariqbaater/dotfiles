#!/bin/sh
#:TODO: Add support for multiple WiFi interfaces and better error handling.

# Simple WiFi status check
WIFI_STATUS=$(ifconfig en0 2>/dev/null | grep "status:" | awk '{print $2}')

if [ "$WIFI_STATUS" = "active" ]; then
  ICON="􀙇"
else
  ICON="􀙈"
fi

sketchybar --set "$NAME" icon="$ICON" label=""
