#!/bin/bash
source "$HOME/.config/sketchybar/colors.sh"

# Get current connection info
WIFI_STATUS=$(ifconfig en0 2>/dev/null | grep "status:" | awk '{print $2}')

if [ "$WIFI_STATUS" = "active" ]; then
  SSID=$(ipconfig getsummary en0 2>/dev/null | awk -F ' : ' '/^  SSID/{print $2}')
  IP=$(ipconfig getifaddr en0 2>/dev/null)
  case "$IP" in
    172.20.10.*) ICON="􀉤" ;;
    *)           ICON="􀙇" ;;
  esac
  LABEL="${SSID:-Connected}"
else
  ICON="􀙈"
  LABEL="Off"
  SSID=""
fi

# Get known networks for reference
KNOWN=$(networksetup -listpreferredwirelessnetworks en0 2>/dev/null | tail -n +2 | sed 's/^[[:space:]]*//')

# Scan available networks from system_profiler
AVAILABLE=$(system_profiler SPAirPortDataType 2>/dev/null | awk '
  /Other Local Wi-Fi Networks:/ { found=1; next }
  found && /^[[:space:]]+[A-Za-z0-9]/ {
    gsub(/^[[:space:]]+/, "")
    gsub(/:/, "")
    print
  }
  found && /^[^[:space:]]/ { found=0 }
')

# Remove old popup items
sketchybar --remove wifi.net_* 2>/dev/null
sketchybar --remove wifi.status 2>/dev/null
sketchybar --remove wifi.sep1 2>/dev/null
sketchybar --remove wifi.join 2>/dev/null
sketchybar --remove wifi.settings 2>/dev/null

# Add current network indicator
sketchybar --add item wifi.status popup.wifi \
           --set wifi.status icon="$ICON" label="$LABEL" \
                             icon.color=$BLUE label.color=$TEXT \
                             background.corner_radius=4 \
                             padding_left=10 padding_right=10 \
                             background.height=28

# Add separator
sketchybar --add item wifi.sep1 popup.wifi \
           --set wifi.sep1 label="───────────────" \
                           label.color=$BORDER_COLOR label.font="SF Pro:Regular:8.0" \
                           background.corner_radius=0 \
                           padding_left=10 padding_right=10 \
                           background.height=10

# Add available networks
i=0
echo "$AVAILABLE" | while read -r network; do
  if [ -n "$network" ]; then
    # Check if it's a known network
    if echo "$KNOWN" | grep -qF "$network"; then
      ICON="􀜚"
    else
      ICON="􀜝"
    fi
    
    sketchybar --add item "wifi.net_$i" popup.wifi \
               --set "wifi.net_$i" icon="$ICON" label="$network" \
                                   icon.color=$TEXT label.color=$TEXT \
                                   click_script="$CONFIG_DIR/plugins/wifi_connect.sh '$network'" \
                                   background.corner_radius=4 \
                                   padding_left=10 padding_right=10 \
                                   background.height=28
    i=$((i + 1))
  fi
done

# Add network settings option
sketchybar --add item wifi.settings popup.wifi \
           --set wifi.settings icon=􀣋 label="Network Settings" \
                               icon.color=$BLUE label.color=$TEXT \
                               click_script="open 'x-apple.systempreferences:com.apple.preference.network'; sketchybar --set wifi popup.drawing=off" \
                               background.corner_radius=4 \
                               padding_left=10 padding_right=10 \
                               background.height=28
