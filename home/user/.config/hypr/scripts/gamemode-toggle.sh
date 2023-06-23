#!/usr/bin/env sh

if [[ $(hyprctl -j getoption animations:enabled | jaq -r ".int") = 1 ]] ; then
    ~/.config/hypr/scripts/gamemode-on.sh
else
    ~/.config/hypr/scripts/gamemode-off.sh
fi
