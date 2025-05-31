#!/bin/bash
#	originally written by: gh0stzk - https://github.com/gh0stzk/dotfiles
#	rewritten for hyprland by :	 develcooking - https://github.com/develcooking/hyprland-dotfiles

# Set some variables
wall_dir="${HOME}/Pictures/wallpapers/images"
cacheDir="${HOME}/.cache/jp/${theme}"
rofi_command="rofi -x11 -dmenu -theme ${HOME}/.config/rofi/generic-selector.rasi -theme-str ${rofi_override}"

# Create cache dir if not exists
if [ ! -d "${cacheDir}" ]; then
  mkdir -p "${cacheDir}"
fi

physical_monitor_size=24
monitor_res=$(hyprctl monitors | grep -A2 Monitor | head -n 2 | awk '{print $1}' | grep -oE '^[0-9]+')
dotsperinch=$(echo "scale=2; $monitor_res / $physical_monitor_size" | bc | xargs printf "%.0f")
monitor_res=$(($monitor_res * $physical_monitor_size / $dotsperinch))

rofi_override="element-icon{size:${monitor_res}px;border-radius:0px;}"

target_width=720
target_height=$(echo "($target_width * 9) / 16" | bc)

for image_file in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
  if [ -f "$image_file" ]; then
    filename=$(basename "$image_file")
    if [ ! -f "${cacheDir}/${filename}" ]; then
      echo "Processing: $filename"
      magick "$image_file" \
        -strip \
        -gravity center \
        -resize "${target_width}x${target_height}^" \
        -extent "${target_width}x${target_height}" \
        "${cacheDir}/${filename}"
    else
      echo "Skipping (already in cache): $filename"
    fi
  fi
done

# Select a picture with rofi
wall_selection=$(find "${wall_dir}" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A; do echo -en "$A\x00icon\x1f""${cacheDir}"/"$A\n"; done | $rofi_command)

# Set the wallpaper
[[ -n "$wall_selection" ]] || exit 1
set_wallpaper.sh ${wall_dir}/${wall_selection}

exit 0
