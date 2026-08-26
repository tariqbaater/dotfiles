#!/bin/bash
source "$HOME/.config/sketchybar/colors.sh"

NETWORK="$1"

# Check if already connected
CURRENT=$(ipconfig getsummary en0 2>/dev/null | awk -F ' : ' '/^  SSID/{print $2}')

if [ "$CURRENT" = "$NETWORK" ]; then
  osascript -e "display notification \"Already connected to $NETWORK\" with title \"Wi-Fi\""
  sketchybar --set wifi popup.drawing=off
  exit 0
fi

# Check if network is known
KNOWN=$(networksetup -listpreferredwirelessnetworks en0 2>/dev/null | grep -F "$NETWORK")

if [ -n "$KNOWN" ]; then
  # Known network - connect directly
  RESULT=$(networksetup -setairportnetwork en0 "$NETWORK" 2>&1)
  sleep 2
  
  NEW_SSID=$(ipconfig getsummary en0 2>/dev/null | awk -F ' : ' '/^  SSID/{print $2}')
  if [ "$NEW_SSID" = "$NETWORK" ]; then
    osascript -e "display notification \"Connected to $NETWORK\" with title \"Wi-Fi\""
  else
    osascript -e "display notification \"Failed to connect: $RESULT\" with title \"Wi-Fi\""
  fi
else
  # Unknown network - prompt for password
  PASSWORD=$(osascript -e "
    set dialogText to \"Enter password for '$NETWORK':\"
    set dialogResult to display dialog dialogText default answer \"\" with title \"Wi-Fi Network\" buttons {\"Cancel\", \"Connect\"} default button \"Connect\" with hidden answer
    return text returned of dialogResult
  " 2>/dev/null)
  
  if [ -n "$PASSWORD" ]; then
    RESULT=$(networksetup -setairportnetwork en0 "$NETWORK" "$PASSWORD" 2>&1)
    sleep 2
    
    NEW_SSID=$(ipconfig getsummary en0 2>/dev/null | awk -F ' : ' '/^  SSID/{print $2}')
    if [ "$NEW_SSID" = "$NETWORK" ]; then
      osascript -e "display notification \"Connected to $NETWORK\" with title \"Wi-Fi\""
    else
      osascript -e "display notification \"Failed to connect: $RESULT\" with title \"Wi-Fi\""
    fi
  fi
fi

sketchybar --set wifi popup.drawing=off
sketchybar --trigger wifi_change
