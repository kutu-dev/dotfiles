#!/usr/bin/env sh

hyprctl reload

if ! pgrep -x "waybar" > /dev/null; then
    waybar &
fi

if ! pgrep -x "swayidle" > /dev/null; then
    swayidle &
fi

dunstify -i ~/.config/hypr/pictures/$(ls ~/.config/hypr/pictures | sort -R | head -1) CALICOMP "Gamemode deactivated"
