#!/bin/bash

LAST_SWITCH_TIME_FILE="$HOME/.last_hyprland_workspace_switch_time"
if [ ! -f "$LAST_SWITCH_TIME_FILE" ]; then
  echo "0" >"$LAST_SWITCH_TIME_FILE"
fi

TARGET_WORKSPACE="$1"

if [ -z "$TARGET_WORKSPACE" ]; then
  echo "Usage: $0 <workspace_number>"
  exit 1
fi

CURRENT_TIME=$(date +%s.%N)
LAST_SWITCH_TIME=$(cat "$LAST_SWITCH_TIME_FILE")
TIME_DIFF=$(echo "$CURRENT_TIME - $LAST_SWITCH_TIME" | bc)

MIN_TIME_DIFF=0.2

if (($(echo "$TIME_DIFF >= $MIN_TIME_DIFF" | bc -l))); then
  hyprctl dispatch workspace "$TARGET_WORKSPACE"
  echo "$CURRENT_TIME" >"$LAST_SWITCH_TIME_FILE"
else
  echo "Ignoring workspace switch. Last switch was too recent ($TIME_DIFF seconds ago)."
fi
