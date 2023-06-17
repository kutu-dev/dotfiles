#!/usr/bin/env sh

if [[ -z $XDG_CONFIG_HOME ]]; then
    config_dir="$HOME/.config"
else
    config_dir=$XDG_CONFIG_HOME
fi

rm -r config
mkdir config

# Full directory and files copy
config_subdirectories="fish kitty dunst eww gamemode.ini hypr kitty Kvantum neofetch rofi starship.toml swayidle swaylock udiskie waybar"

for subdirectory in $config_subdirectories; do
    cp -r $config_dir/$subdirectory config
done
