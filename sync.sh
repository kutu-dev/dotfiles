#!/usr/bin/env sh

if [[ -z $XDG_CONFIG_HOME ]]; then
    config_dir="$HOME/.config"
else
    config_dir=$XDG_CONFIG_HOME
fi

# Copy dotfiles from XDG_CONFIG_HOME
rm -r config
mkdir config

config_subdirectories="fish kitty dunst eww gamemode.ini hypr kitty Kvantum neofetch rofi starship.toml swayidle swaylock udiskie waybar"

for subdirectory in $config_subdirectories; do
    cp -r $config_dir/$subdirectory config
done

# Copy GRUB themes
rm -r grub
mkdir -p grub/themes

cp -r /boot/grub/themes/* grub/themes
