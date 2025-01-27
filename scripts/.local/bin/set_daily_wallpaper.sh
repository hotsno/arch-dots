#!/bin/bash

file_mod_date=$(date -r ~/.wallpaper +%Y-%m-%d 2>/dev/null)
today_date=$(date +%Y-%m-%d)

if [[ -f ~/.wallpaper && "$file_mod_date" != "$today_date" ]]; then
  set_random_wallpaper.sh
fi

