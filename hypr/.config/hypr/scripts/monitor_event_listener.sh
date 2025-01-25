#!/usr/bin/env bash

handle() {
  case $1 in
    monitoradded*) /home/hotsno/.local/bin/handle_monitors.sh ;;
    monitorremoved*) /home/hotsno/.local/bin/handle_monitors.sh ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
