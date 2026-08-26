#!/bin/bash
source "$HOME/.config/sketchybar/colors.sh"
CONFIG_DIR="$HOME/.config/sketchybar"

# Toggle popup
CURRENT=$(sketchybar --query wifi 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('popup',{}).get('drawing','off'))" 2>/dev/null || echo "off")
if [ "$CURRENT" = "on" ]; then
  sketchybar --set wifi popup.drawing=off
  exit 0
fi

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

# Get known networks
KNOWN=$(networksetup -listpreferredwirelessnetworks en0 2>/dev/null | tail -n +2 | sed 's/^[[:space:]]*//')

# Remove old popup items
sketchybar --remove wifi.net_* 2>/dev/null
sketchybar --remove wifi.status 2>/dev/null
sketchybar --remove wifi.sep1 2>/dev/null
sketchybar --remove wifi.sep2 2>/dev/null
sketchybar --remove wifi.scan 2>/dev/null
sketchybar --remove wifi.settings 2>/dev/null
sketchybar --remove wifi.toggle 2>/dev/null

# Add current network indicator
sketchybar --add item wifi.status popup.wifi \
           --set wifi.status icon="$ICON" label="$LABEL" \
                             icon.color=$BLUE label.color=$TEXT \
                             background.corner_radius=4 \
                             padding_left=10 padding_right=10 \
                             background.height=28

# Add toggle wifi option
if [ "$WIFI_STATUS" = "active" ]; then
  sketchybar --add item wifi.toggle popup.wifi \
             --set wifi.toggle icon=􀙈 label="Turn Wi-Fi Off" \
                               icon.color=$RED label.color=$TEXT \
                               click_script="networksetup -setairportpower en0 off; sketchybar --set wifi popup.drawing=off; sketchybar --trigger wifi_change" \
                               background.corner_radius=4 \
                               padding_left=10 padding_right=10 \
                               background.height=28
else
  sketchybar --add item wifi.toggle popup.wifi \
             --set wifi.toggle icon=􀙇 label="Turn Wi-Fi On" \
                               icon.color=$GREEN label.color=$TEXT \
                               click_script="networksetup -setairportpower en0 on; sleep 2; sketchybar --set wifi popup.drawing=off; sketchybar --trigger wifi_change" \
                               background.corner_radius=4 \
                               padding_left=10 padding_right=10 \
                               background.height=28
fi

# Add separator
sketchybar --add item wifi.sep1 popup.wifi \
           --set wifi.sep1 label="───────────────" \
                           label.color=$BORDER_COLOR label.font="SF Pro:Regular:8.0" \
                           background.corner_radius=0 \
                           padding_left=10 padding_right=10 \
                           background.height=10

# Add known networks
i=0
echo "$KNOWN" | while IFS= read -r network; do
  if [ -n "$network" ]; then
    if [ "$network" = "$SSID" ]; then
      NETICON="􀋪"
      ICON_COLOR=$GREEN
    else
      NETICON="􀜚"
      ICON_COLOR=$TEXT
    fi
    
    sketchybar --add item "wifi.net_$i" popup.wifi
    sketchybar --set "wifi.net_$i" icon="$NETICON" label="$network"
    sketchybar --set "wifi.net_$i" icon.color="$ICON_COLOR" label.color="$TEXT"
    sketchybar --set "wifi.net_$i" click_script="$CONFIG_DIR/plugins/wifi_connect.sh \"$network\""
    sketchybar --set "wifi.net_$i" background.corner_radius=4 padding_left=10 padding_right=10 background.height=28
    i=$((i + 1))
  fi
done <<EOF
$KNOWN
EOF

# Add separator before actions
sketchybar --add item wifi.sep2 popup.wifi \
           --set wifi.sep2 label="───────────────" \
                           label.color=$BORDER_COLOR label.font="SF Pro:Regular:8.0" \
                           background.corner_radius=0 \
                           padding_left=10 padding_right=10 \
                           background.height=10

# Add join other network
sketchybar --add item wifi.scan popup.wifi \
           --set wifi.scan icon=􀅳 label="Join Other Network..." \
                           icon.color=$BLUE label.color=$TEXT \
                           click_script="networksetup -setairportnetwork en0; sketchybar --set wifi popup.drawing=off" \
                           background.corner_radius=4 \
                           padding_left=10 padding_right=10 \
                           background.height=28

# Add network settings
sketchybar --add item wifi.settings popup.wifi \
           --set wifi.settings icon=􀣋 label="Network Settings" \
                               icon.color=$BLUE label.color=$TEXT \
                               click_script="open 'x-apple.systempreferences:com.apple.preference.network'; sketchybar --set wifi popup.drawing=off" \
                               background.corner_radius=4 \
                               padding_left=10 padding_right=10 \
                               background.height=28

# Show popup
sketchybar --set wifi popup.drawing=on
