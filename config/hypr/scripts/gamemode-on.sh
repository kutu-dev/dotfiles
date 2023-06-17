#!/usr/bin/env sh

hyprctl --batch "\
    keyword animations:enabled 0;\
    keyword decoration:drop_shadow 0;\
    keyword decoration:blur 0;\
    keyword general:gaps_in 0;\
    keyword general:gaps_out 0;\
    keyword general:border_size 1;\
    keyword decoration:rounding 0;\
    keyword unbind ALT,SPACE;\
    keyword unbind CONTROL,SPACE"
killall waybar
killall swayidle
dunstify -i ~/.config/hypr/pictures/$(ls ~/.config/hypr/pictures | sort -R | head -1) CALICOMP "Gamemode activated"
