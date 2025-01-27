#!/usr/bin/env bash

# if hyprctl monitors | grep -q "Advanced Micro Peripherals Ltd ES07D03 EVE220200961"; then

set_wallpaper.sh

if (( $(hyprctl monitors | grep -oE "\(ID [0-9]+\)" | wc -l) > 1 )); then # >1 display on + connected
  if cat /proc/acpi/button/lid/LID0/state | grep -q "open"; then
    hyprctl dispatch moveworkspacetomonitor 1 DP-1 # Can't target by name/desc :/
    hyprctl dispatch moveworkspacetomonitor 2 DP-1
    hyprctl dispatch moveworkspacetomonitor 3 DP-1
    hyprctl dispatch moveworkspacetomonitor 4 DP-1
    hyprctl dispatch moveworkspacetomonitor 5 DP-1
    hyprctl dispatch moveworkspacetomonitor 6 DP-1
    hyprctl dispatch moveworkspacetomonitor 7 DP-1
    if [ "$1" != "noreload" ]; then
      hyprctl reload
    fi
  else
    hyprctl keyword monitor eDP-1, disable
  fi
else
  if cat /proc/acpi/button/lid/LID0/state | grep -q "open"; then
    if [ "$1" != "noreload" ]; then
      hyprctl reload
    fi
  else
    hyprlock & systemctl suspend
  fi
fi

