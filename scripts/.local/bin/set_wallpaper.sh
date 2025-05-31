#!/bin/bash

if [ -n "$1" ]; then
  cp "$1" ~/.wallpaper
fi

swww img ~/.wallpaper -t wipe --transition-fps 120 --transition-duration 1
