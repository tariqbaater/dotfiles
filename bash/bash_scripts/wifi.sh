#!/bin/bash

# This script is used to connect to a hotspot network using networksetup

# Assign arguments to variables
SSID="TaRiQ++++bAaTeR"
PASSWORD="12345679"
# Check if the Wi-Fi interface is available
# Get the Wi-Fi interface name
WIFI_INTERFACE=$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')
if [ -z "$WIFI_INTERFACE" ]; then
    echo "Wi-Fi interface not found."
    exit 1
fi
# Check if the Wi-Fi is already connected to the specified SSID
# Get the current SSID
CURRENT_SSID=$(ipconfig getsummary en0 2>/dev/null | awk -F ' : ' '/^  SSID/{print $2}')
if [ "$CURRENT_SSID" == "$SSID" ]; then
    echo "Already connected to $SSID."
    exit 0
fi
# Disconnect from the current network if connected
if [ -n "$CURRENT_SSID" ]; then
    echo "Disconnecting from $CURRENT_SSID..."
    networksetup -setairportpower "$WIFI_INTERFACE" off
    sleep 2
fi
# Connect to the specified Wi-Fi network
# Turn on the Wi-Fi interface
echo "Connecting to $SSID..."
networksetup -setairportpower "$WIFI_INTERFACE" on
# Wait for the Wi-Fi interface to be ready
sleep 5
# Use networksetup to connect to the Wi-Fi network
networksetup -setairportnetwork "$WIFI_INTERFACE" "$SSID" "$PASSWORD"
# Check if the connection was successful
if [ $? -eq 0 ]; then
    echo "Successfully connected to $SSID."
else
    echo "Failed to connect to $SSID. Please check the SSID and password."
    exit 1
fi
