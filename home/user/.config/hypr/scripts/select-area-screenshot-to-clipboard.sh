#!/usr/bin/env sh

if ! pgrep -x "slurp" > /dev/null; then
    grim -g "$(slurp -b '#000000a5' -c '#7aa2f7')" - | wl-copy
    dunstify -i ~/.config/hypr/pictures/$(ls ~/.config/hypr/pictures | sort -R | head -1) CALICOMP "Screenshot saved to clipboard"
fi
