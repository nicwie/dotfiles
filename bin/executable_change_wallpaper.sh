#!/usr/bin/env bash

# Fully taken from the hyprland wiki on hyprpaper
# https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Random wallpaper but not current
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply found wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"
