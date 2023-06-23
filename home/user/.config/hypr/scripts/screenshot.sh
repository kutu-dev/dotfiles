#!/usr/bin/env sh

SCREENSHOT_PATH=~/pictures/screenshots/$(date "+%d-%m-%Y-%H-%M-%S.png")
grim $SCREENSHOT_PATH
dunstify -i ~/.config/hypr/pictures/$(ls ~/.config/hypr/pictures | sort -R | head -1) CALICOMP "Screenshot saved at $SCREENSHOT_PATH"
