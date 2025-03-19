#!/bin/bash

# Simple Night Light toggle script for Hyprland
# Uses `hyprsunset` to enable/disable night light.

STATE_FILE="/tmp/hypr_nightlight_state"
NIGHT_TEMP=5000
DAY_TEMP=6500

# Function to check current status
is_nightlight_active() {
    pgrep -x "hyprsunset" > /dev/null
}

# Toggle function
toggle_nightlight() {
    if is_nightlight_active; then
        killall hyprsunset

        echo "󰖧" > "$STATE_FILE"  # Save state
    else
        nohup hyprsunset --temperature "$NIGHT_TEMP" > /dev/null 2>&1 &

        echo "󰖨" > "$STATE_FILE"  # Save state
    fi
}

# If called with "toggle", switch the mode
if [[ "$1" == "toggle" ]]; then
    toggle_nightlight
    exit 0
fi

# Display current status in Waybar
if is_nightlight_active; then
    echo "󰖨"
else
    echo "󰖧"
fi

