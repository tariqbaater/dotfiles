# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a SketchyBar configuration for macOS. SketchyBar is a highly customizable menu bar replacement for macOS that uses shell scripts and a declarative configuration approach. This configuration integrates with AeroSpace window manager for workspace management.

## Configuration Architecture

### Main Configuration Flow

1. **sketchybarrc** - Main entry point that orchestrates the entire bar setup:
   - Sources `colors.sh` to load the color scheme
   - Configures bar appearance (position, height, blur, borders, padding, and corner radius)
   - Sets default item properties (fonts, padding, colors)
   - Adds left items (Apple logo, AeroSpace workspaces, front app indicator, VPN)
   - Adds right items (clock, Bluetooth, volume, battery, Wi-Fi)
   - Subscribes items to relevant events

2. **colors.sh** - Centralized color definitions with multiple theme options:
   - Currently using Teal scheme (BAR_COLOR, ITEM_BG_COLOR, ACCENT_COLOR)
   - Contains commented-out alternatives: Gray, Purple, Red, Blue, Green, Orange, Yellow
   - All colors use ARGB hex format (0xAARRGGBB)

3. **items/** directory - Contains individual item configuration scripts:
   - Current items include `apple_logo.sh`, `workspaces.sh`, `front_app.sh`, `vpn.sh`, `clock.sh`, `bluetooth.sh`, `volume.sh`, `battery.sh`, and `wifi.sh`.
   - These scripts are responsible for setting up specific bar items by configuring and setting up item properties and bindings.

4. **plugins/** directory - Contains executable scripts that update bar items:
   - Plugins include `battery.sh`, `clock.sh`, `aerospace.sh`, `wifi.sh`, `front_app.sh`, `icon_map_fn.sh`, `vpn.sh`, `bluetooth.sh`, and `volume.sh.`
   - Each plugin responds to either periodic updates or event-driven changes
   - Plugins use environment variables passed by SketchyBar ($NAME, $SENDER, $INFO, etc.)

### Key Integration: AeroSpace Window Manager

The configuration dynamically creates workspace indicators based on AeroSpace:

- Iterates through active workspaces using `aerospace list-workspaces --all`
- Creates a `space.$sid` item for each workspace
- Subscribes to `aerospace_workspace_change` event
- **aerospace.sh** plugin highlights the focused workspace by toggling background drawing

### Plugin Architecture

Each plugin follows a pattern:

- Receives context via environment variables ($NAME, $SENDER, $INFO, $FOCUSED_WORKSPACE)
- Processes information (parsing system data, checking conditions)
- Updates the bar item using `sketchybar --set $NAME <properties>`

**Key plugins:**

- **aerospace.sh** (dynamically highlights workspaces)
- **front_app.sh** (displays active app)
- **battery.sh** (battery status and icons)
- **wifi.sh** (Wi-Fi status/signals)
- **vpn.sh** (VPN status and events)
- **bluetooth.sh** (Bluetooth devices)
- **volume.sh** (volume level and mute status)
- **clock.sh** (current time display and date)
- **icon_map_fn.sh** (handles dynamic icon mapping for events and items)

## Reloading Configuration

After making changes to configuration files:

```bash
# Restart SketchyBar to apply changes
brew services restart sketchybar

# Or reload configuration in-place (from current_space.sh pattern)
sketchybar --remove '/.*/' && source ~/.config/sketchybar/sketchybarrc
```

## Testing Plugins

Test individual plugins by simulating SketchyBar's environment:

```bash
# Set required environment variables
export NAME="item_name"
export SENDER="event_name"
export INFO="event_info"
export CONFIG_DIR="$HOME/.config/sketchybar"
export FOCUSED_WORKSPACE="1"

# Run the plugin
./plugins/aerospace.sh 1
```

## Modifying Color Schemes

To change the theme, edit `colors.sh`:

1. Comment out current scheme (Teal by default)
2. Uncomment desired scheme
3. Reload SketchyBar

## Event System

SketchyBar uses an event-driven architecture:

- **Custom events**: `aerospace_workspace_change` (triggered by AeroSpace)
- **System events**: `volume_change`, `front_app_switched`, `system_woke`, `power_source_change`
- Items subscribe to events using `--subscribe <item_name> <event_name>`
- Events pass contextual data through `$INFO` variable

## Font Requirements

Configuration uses **SF Pro**:

- Icons: Semibold 14.0
- Labels: Semibold 12.0
- Ensure SF Pro font is installed for proper icon rendering

## File Permissions

Plugin scripts must be executable:

```bash
chmod +x plugins/*.sh
```
