#!/bin/sh

# Check for connected AirPods/Bluetooth audio
BT_INFO=$(system_profiler SPBluetoothDataType 2>/dev/null)

# Look for connected AirPods
AIRPODS=$(echo "$BT_INFO" | grep -A 15 "Abuu’s AirPods Pro" | grep -B 5 "Connected:" | head -1 | sed 's/^[[:space:]]*//;s/:$//')

if [ -n "$AIRPODS" ]; then
  # Try to get battery level from connected AirPods
  BATTERY=$(echo "$BT_INFO" | grep -A 20 "$AIRPODS" | grep "Battery Level" | head -1 | sed 's/.*: //')

  ICON=" 􀪷"
  LABEL=""
  if [ -n "$BATTERY" ]; then
    LABEL="$BATTERY"
  else
    LABEL=""
  fi
else
  # Check for any other connected Bluetooth headphones
  BT_HEADPHONES=$(echo "$BT_INFO" | grep -B 5 "Connected: Yes" | grep -B 5 "Minor Type: Headphones" | head -1 | sed 's/^[[:space:]]*//;s/:$//')

  if [ -n "$BT_HEADPHONES" ]; then
    ICON=" 􀑈"
    LABEL=""
  else
    ICON=" 􂬂"
    LABEL=""
  fi
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
