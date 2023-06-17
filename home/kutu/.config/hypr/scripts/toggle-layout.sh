#!/usr/bin/env sh

if [[ $(hyprctl -j getoption general:layout | jaq -r ".str") = "master" ]]; then
  hyprctl keyword general:layout "dwindle"
  dunstify -i ~/.config/hypr/pictures/$(ls ~/.config/hypr/pictures | sort -R | head -1) CALICOMP "Layout set to Dwindle"
else
  hyprctl keyword general:layout "master"
  dunstify -i ~/.config/hypr/pictures/$(ls ~/.config/hypr/pictures | sort -R | head -1) CALICOMP "Layout set to Master"
fi
