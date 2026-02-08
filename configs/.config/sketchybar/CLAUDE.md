# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a SketchyBar configuration for macOS. SketchyBar is a highly customizable menu bar replacement for macOS that uses shell scripts and a declarative configuration approach. This configuration integrates with AeroSpace window manager for workspace management.

## Configuration Architecture

### Main Configuration Flow

1. **sketchybarrc** - Main entry point that orchestrates the entire bar setup:
   - Sources `colors.sh` to load the color scheme
   - Configures bar appearance (position, height, blur)
   - Sets default item properties (fonts, padding, colors)
   - Adds left items (Apple logo, AeroSpace workspaces, front app indicator)
   - Adds right items (clock, volume, battery)
   - Subscribes items to relevant events

2. **colors.sh** - Centralized color definitions with multiple theme options:
   - Currently using Teal scheme (BAR_COLOR, ITEM_BG_COLOR, ACCENT_COLOR)
   - Contains commented-out alternatives: Gray, Purple, Red, Blue, Green, Orange, Yellow
   - All colors use ARGB hex format (0xAARRGGBB)

3. **plugins/** directory - Contains executable scripts that update bar items:
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
- **aerospace.sh** - Toggles workspace background highlighting based on focus
- **front_app.sh** - Displays currently focused application name
- **battery.sh** - Shows battery percentage and charging status with dynamic icons
- **clock.sh** - Displays current date/time (updates every 10s)
- **volume.sh** - Shows volume level with dynamic icons (event-driven via volume_change)
- **current_space.sh** - Alternative workspace indicator with click-to-reload functionality

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

Configuration uses **Hack Nerd Font**:
- Icons: Bold 17.0
- Labels: Bold 14.0
- Ensure Nerd Font is installed for proper icon rendering

## File Permissions

Plugin scripts must be executable:

```bash
chmod +x plugins/*.sh
```
