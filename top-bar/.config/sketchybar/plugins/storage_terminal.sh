#!/bin/bash
open -a Ghostty
sleep 1
osascript -e 'tell application "System Events" to keystroke "df -h"'
osascript -e 'tell application "System Events" to key code 36'
