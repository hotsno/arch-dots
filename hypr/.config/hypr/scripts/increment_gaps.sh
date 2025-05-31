#!/bin/bash

INCREMENT=50
DEFAULT_GAP=10

workspace_json=$(hyprctl activeworkspace -j)
workspace_id=$(echo "$workspace_json" | jq -r '.id')
workspacerules_json=$(hyprctl workspacerules -j)
current_gap=$(echo "$workspacerules_json" | jq -r ".[] | select(.workspaceString == \"$workspace_id\") | .gapsOut[0]")

if [ -z "$current_gap" ]; then
  current_gap=$DEFAULT_GAP
fi

if [ "$1" == "increase" ]; then
  new_gap=$((current_gap + INCREMENT))
elif [ "$1" == "decrease" ]; then
  new_gap=$((current_gap - INCREMENT))
  if [ "$new_gap" -lt 10 ]; then
    new_gap=10
  fi
else
  echo "Usage: $0 [increase|decrease]"
  exit 1
fi

hyprctl keyword "workspace $workspace_id, gapsout:$new_gap"

echo "Workspace $workspace_id gaps set to $new_gap"
