#!/bin/bash

DEFAULT_GAP=10
ZEN_GAP="175 225 175 225"

workspace_json=$(hyprctl activeworkspace -j)
workspace_id=$(echo "$workspace_json" | jq -r '.id')
workspacerules_json=$(hyprctl workspacerules -j)
current_gap=$(echo "$workspacerules_json" | jq -r ".[] | select(.workspaceString == \"$workspace_id\") | .gapsOut[0]")

if [ -z "$current_gap" ] || [ "$current_gap" == "null" ] || [ "$current_gap" -eq 10 ]; then
  new_gap=$ZEN_GAP
else
  new_gap=$DEFAULT_GAP
fi

hyprctl keyword "workspace $workspace_id, gapsout:$new_gap"

echo "Workspace $workspace_id gaps set to $new_gap"

# top, right, bottom, left
