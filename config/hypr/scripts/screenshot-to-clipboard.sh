#!/usr/bin/env sh

grim - | wl-copy
dunstify -i ~/.config/hypr/pictures/$(ls ~/.config/hypr/pictures | sort -R | head -1) CALICOMP "Screenshot saved to clipboard"