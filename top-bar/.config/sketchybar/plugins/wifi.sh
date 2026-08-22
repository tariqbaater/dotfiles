#!/bin/sh

WIFI_STATUS=$(ifconfig en0 2>/dev/null | grep "status:" | awk '{print $2}')

if [ "$WIFI_STATUS" = "active" ]; then
  SSID=$(ipconfig getsummary en0 2>/dev/null | awk -F ' : ' '/^  SSID/{print $2}')
  IP=$(ipconfig getifaddr en0 2>/dev/null)

  # Personal hotspots use the 172.20.10.x subnet
  case "$IP" in
    172.20.10.*) ICON="􀉤" ;;  # hotspot icon
    *)           ICON="􀙇" ;;  # wifi icon
  esac

  LABEL="${SSID:-Connected}"
else
  ICON="􀙈"
  LABEL="Off"
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
