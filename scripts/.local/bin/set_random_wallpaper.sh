RANDOM_WALLPAPER_PATH="$(find $HOME/Developer/wallpapers -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | sort -R | head -n 1)"

swww img $RANDOM_WALLPAPER_PATH -t wipe --transition-fps 120 --transition-duration 1

curl -X PUT -H "Content-Type: text/plain" -H "Authorization: 51dae4350bf03307bf08989b538d28c9" -d "https://github.com/hotsno/wallpapers/blob/main/$(basename $RANDOM_WALLPAPER_PATH)?raw=true" "https://api.lanyard.rest/v1/users/707743097488146524/kv/wallpaper_url"
