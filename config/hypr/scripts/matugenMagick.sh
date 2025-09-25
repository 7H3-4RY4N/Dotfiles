#!/usr/bin/env bash

# Get current wallpaper path from swww query
wallpaper_path=$(swww query | grep "image:" | head -n 1 | awk -F'image: ' '{print $2}')

if [[ -z "$wallpaper_path" ]]; then
    notify-send -e "MatugenMagick Failed" "Could not determine current wallpaper path!"
    exit 1
fi

# Directory where Matugen writes colorschemes (adjust if you use a custom location)
MATUGEN_DIR="$HOME/.config/matugen"

# Generate matugen colors
if [[ "$1" == "--light" ]]; then
    matugen image "$wallpaper_path" -m light
else
    matugen image "$wallpaper_path" -m dark
fi

# Wait until Matugen has finished writing files
if [[ -d "$MATUGEN_DIR" ]]; then
    for i in {1..30}; do
        last_mod=$(find "$MATUGEN_DIR" -type f -printf '%T@\n' | sort -n | tail -1)
        now=$(date +%s)
        if (( $(echo "$now - $last_mod < 2" | bc -l) )); then
            break
        fi
        sleep 0.1
    done
fi

# Reset GTK theme so new colors apply
gsettings set org.gnome.desktop.interface gtk-theme ""
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3

# Generate rofi preview images
blurred="$HOME/.config/rofi/images/currentWalBlur.thumb"
thumb="$HOME/.config/rofi/images/currentWal.thumb"
square="$HOME/.config/rofi/images/currentWal.sqre"
quad="$HOME/.config/rofi/images/currentWalQuad.quad"

magick "$wallpaper_path" -strip -resize 1000 -gravity center -extent 1000 -blur "30x30" -quality 90 "$blurred"
magick "$wallpaper_path" -strip -resize 1000 -gravity center -extent 1000 -quality 90 "$thumb"
magick "$wallpaper_path" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "$square"

magick "$square" \
    \( -size 500x500 xc:white -fill "rgba(0,0,0,0.7)" -draw "polygon 400,500 500,500 500,0 450,0" \
       -fill black -draw "polygon 500,500 500,0 450,500" \) \
    -alpha Off -compose CopyOpacity -composite "$quad"

# Update symlink for current wallpaper
ln -sf "$wallpaper_path" "$HOME/.local/share/bg"

# Notify user
notify-send -e -h string:x-canonical-private-synchronous:matugen_notif \
    "Matugen Magick has completed its job." -i "$HOME/.local/share/bg"

