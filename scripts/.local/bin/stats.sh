#!/bin/bash

# Get current volume
# Using pactl for PipeWire interaction
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep 'Volume:' | awk '{print $5}' | sed 's/%//')

# Get current default audio source (input device)
# Using pactl to find the default source name
source_name=$(pactl get-default-sink)

# Get current brightness (adjust path based on your hardware, this is a common location)
# Using brightnessctl for display brightness
brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
brightness_percent=$(((brightness * 100) / max_brightness))

# Get battery percentage
# Using awk to extract the percentage from the capacity file
if [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
  battery_percent=$(cat /sys/class/power_supply/BAT0/capacity)
else
  battery_percent="N/A"
fi

# Get battery charging state
# Using cat to read the status file
if [[ -f /sys/class/power_supply/BAT0/status ]]; then
  battery_status=$(cat /sys/class/power_supply/BAT0/status)
else
  battery_status="N/A"
fi

# Add these lines to your echo statements
echo "Battery: ${battery_percent}% (${battery_status})"

echo "Volume: ${volume}%"
echo "Audio source: ${source_name}"
echo "Brightness: ${brightness_percent}%"
