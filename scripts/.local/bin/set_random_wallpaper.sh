RANDOM_WALLPAPER_PATH="$(find $HOME/Pictures/wallpapers/images -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | sort -R | head -n 1)"

set_wallpaper.sh $RANDOM_WALLPAPER_PATH

curl -X PUT -H "Content-Type: text/plain" -H "Authorization: 51dae4350bf03307bf08989b538d28c9" -d "https://github.com/hotsno/wallpapers/blob/main/images/$(basename $RANDOM_WALLPAPER_PATH)?raw=true" "https://api.lanyard.rest/v1/users/707743097488146524/kv/wallpaper_url"
