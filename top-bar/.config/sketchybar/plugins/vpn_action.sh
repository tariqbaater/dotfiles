#!/bin/bash
source "$HOME/.config/sketchybar/colors.sh"

ACTION="$1"
OPENVPNBinary='"/Applications/OpenVPN Connect/OpenVPN Connect.app/Contents/MacOS/OpenVPN Connect"'

# Check if OpenVPN Connect is running via menu bar presence
is_running() {
  osascript -e '
    try
      tell application "System Events"
        tell process "OpenVPN Connect"
          if exists menu bar item 1 of menu bar 2 then
            return "true"
          end if
          if exists menu bar item 1 of menu bar 1 then
            return "true"
          else
            return "false"
          end if
        end tell
      end tell
    on error
      return "false"
    end try
  ' 2>/dev/null
}

# Get menu bar items
get_menu_items() {
  osascript -e '
    try
      tell application "System Events" to tell process "OpenVPN Connect"
        try
          set menuBarItems to name of every menu item of menu 1 of menu bar item 1 of menu bar 2
          return menuBarItems
        end try
        try
          set menuBarItems to name of every menu item of menu 1 of menu bar item 1 of menu bar 1
          return menuBarItems
        end try
      end tell
      return ""
    on error
      return ""
    end try
  ' 2>/dev/null
}

# Get connection status and selected profile
get_status() {
  local menu_items
  menu_items=$(get_menu_items)

  if [ -z "$menu_items" ]; then
    echo "false|"
    return
  fi

  # Check if Disconnect is in menu (means connected)
  if echo "$menu_items" | grep -q "Disconnect"; then
    # Extract profile name (item before Disconnect)
    local profile_name
    profile_name=$(echo "$menu_items" | sed 's/, /\n/g' | sed -n '/Disconnect/{g;P;d;};h' | head -1)
    if [ -z "$profile_name" ]; then
      profile_name=$(echo "$menu_items" | cut -d',' -f1 | xargs)
    fi
    echo "true|$profile_name"
  else
    # Extract profile name (item before Connect)
    local profile_name
    profile_name=$(echo "$menu_items" | sed 's/, /\n/g' | sed -n '/Connect/{g;P;d;};h' | head -1)
    if [ -z "$profile_name" ]; then
      profile_name=$(echo "$menu_items" | cut -d',' -f1 | xargs)
    fi
    echo "false|$profile_name"
  fi
}

# Connect to a profile
connect_profile() {
  local profile_name="$1"
  local selected_profile="$2"

  osascript -e "
    on run argv
      set profileName to item 1 of argv
      set selectedProfileName to item 2 of argv
      try
        tell application \"System Events\" to tell process \"OpenVPN Connect\"
          click menu item profileName of menu selectedProfileName of menu item selectedProfileName of menu 1 of menu bar item 1 of menu bar 2
        end tell
      on error
        try
          tell application \"System Events\" to tell process \"OpenVPN Connect\"
            click menu item profileName of menu selectedProfileName of menu item selectedProfileName of menu 1 of menu bar item 1 of menu bar 1
          end tell
        end try
      end try
    end run
  " "$profile_name" "$selected_profile" 2>/dev/null
}

# Disconnect
do_disconnect() {
  osascript -e '
    try
      tell application "System Events" to tell process "OpenVPN Connect"
        click menu item "Disconnect" of menu 1 of menu bar item 1 of menu bar 2
      end tell
    on error
      try
        tell application "System Events" to tell process "OpenVPN Connect"
          click menu item "Disconnect" of menu 1 of menu bar item 1 of menu bar 1
        end tell
      end try
    end try
  ' 2>/dev/null
}

# Start OpenVPN if not running
start_openvpn() {
  eval "$OPENVPNBinary" &
  sleep 2
  eval "$OPENVPNBinary --minimize" 2>/dev/null
  # Wait for menu bar
  local i=0
  while [ $i -lt 32 ]; do
    if [ "$(is_running)" = "true" ]; then
      return 0
    fi
    sleep 0.25
    i=$((i + 1))
  done
  return 1
}

case "$ACTION" in
  connect)
    if [ "$(is_running)" != "true" ]; then
      if ! start_openvpn; then
        osascript -e 'display notification "OpenVPN Connect failed to start" with title "VPN"'
        exit 1
      fi
    fi

    status=$(get_status)
    is_connected=$(echo "$status" | cut -d'|' -f1)
    profile_name=$(echo "$status" | cut -d'|' -f2)

    if [ "$is_connected" = "true" ]; then
      osascript -e 'display notification "VPN is already connected" with title "VPN"'
    elif [ -z "$profile_name" ]; then
      osascript -e 'display notification "No profile found. Open OpenVPN Connect first." with title "VPN"'
    else
      connect_profile "$profile_name" "$profile_name"
      sleep 1
      osascript -e "display notification \"Connecting to $profile_name...\" with title \"VPN\""
    fi
    ;;
  disconnect)
    if [ "$(is_running)" = "true" ]; then
      do_disconnect
      sleep 1
      osascript -e 'display notification "VPN disconnected" with title "VPN"'
    else
      osascript -e 'display notification "VPN is not connected" with title "VPN"'
    fi
    ;;
  *)
    echo "Usage: $0 {connect|disconnect}"
    exit 1
    ;;
esac

# Close popup and trigger update
sketchybar --set vpn popup.drawing=off
sketchybar --trigger vpn_change
