#!/usr/bin/env bash

# Get current wallpaper path from swww query
wallpaper_path=$(swww query | grep "image:" | head -n 1 | awk -F'image: ' '{print $2}')

if [[ -z "$wallpaper_path" ]]; then
    notify-send -e "MatugenMagick Failed" "Could not determine current wallpaper path!"
    exit 1
fi

# Directory where Matugen writes colorschemes 
MATUGEN_DIR="$HOME/.config/matugen"

# Generate matugen colors
if [[ "$1" == "--light" ]]; then
    matugen image "$wallpaper_path" -m light
else
    matugen image "$wallpaper_path" -m dark
fi

sleep 0.05

# Wait until Matugen has finished writing files 

if [[ -d "$MATUGEN_DIR" ]]; then
    for i in {1..5}; do # Reduced loop: check up to 5 times (0.25s max)
        last_mod=$(find "$MATUGEN_DIR" -type f -printf '%T@\n' | sort -n | tail -1)
        now=$(date +%s)
        # Check if file modification was less than 1 second ago
        if (( $(echo "$now - $last_mod < 1" | bc -l) )); then 
            break
        fi
        sleep 0.05 # Smaller sleep increment
    done
fi

# Reset GTK theme so new colors apply
gsettings set org.gnome.desktop.interface gtk-theme ""
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark

# Update symlink for current wallpaper
ln -sf "$wallpaper_path" "$HOME/.local/share/bg"

# Notify user
notify-send -e -h string:x-canonical-private-synchronous:matugen_notif \
    "Matugen has completed its job." -i "$HOME/.local/share/bg"

exit 0
