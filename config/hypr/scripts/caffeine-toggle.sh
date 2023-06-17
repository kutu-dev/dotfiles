#!/usr/bin/env sh

if pgrep -x "swayidle" > /dev/null; then
    killall swayidle
    pkill -SIGRTMIN+9 waybar
    dunstify -i ~/.config/hypr/pictures/$(ls ~/.config/hypr/pictures | sort -R | head -1) "CALICOMP" "Your PC is now caffeinated"
else
    swayidle &
    pkill -SIGRTMIN+9 waybar
    dunstify -i ~/.config/hypr/pictures/$(ls ~/.config/hypr/pictures | sort -R | head -1) CALICOMP "Your PC is now decaffeinated"
fi
