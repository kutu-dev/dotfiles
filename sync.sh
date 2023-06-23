#!/usr/bin/env sh

if [[ -z $XDG_CONFIG_HOME ]]; then
    config_dir="$HOME/.config"
else
    config_dir=$XDG_CONFIG_HOME
fi

# Copy dotfiles from XDG_CONFIG_HOME
rm -rf home

config_subdirectories="fish kitty dunst eww gamemode.ini hypr kitty Kvantum neofetch rofi starship.toml swayidle swaylock udiskie waybar user-dirs.dirs spicetify/config-xpui.ini spicetify/CustomApps spicetify/Extensions spicetify/Themes gtk-3.0/settings.ini VSCodium/User/settings.json"

for subdirectory in $config_subdirectories; do
    cp -r --parents $config_dir/$subdirectory .
done

# Copy user profile picture
cp -r --parents ~/.face .

# Copy GTK theme
cp -r --parents ~/.themes .

# Copy rofi theme
cp -r --parents ~/.local/share/rofi/themes/tokyo-night.rasi .

# Copy cursor config
cp -r --parents ~/.local/share/icons/default/index.theme .
cp -r --parents ~/.icons/default/index.theme .

# Copy Firefox profile
cp -r --parents ~/.mozilla/firefox/profiles.ini .
cp -r --parents ~/.mozilla/firefox/calicomp/prefs.js .
cp -r --parents ~/.mozilla/firefox/calicomp/chrome .

# Copy Web Apps data and desktop entries
find ~/.local/share/applications -type f -name "webapp-*" -exec cp -r --parents "{}" . ";"
cp -r --parents ~/.local/share/ice/icons .
for profile in ~/.local/share/ice/firefox/*; do
    if [[ $(basename $profile) == "Shared" ]]; then
        continue
    fi

    cp -r --parents $profile/prefs.js .
    cp -r --parents $profile/chrome .
done

# Save VSCodium extensions
codium --list-extensions > vscodium-extensions.txt

# Copy one of my wallpapers
cp -r --parents ~/pictures/wallpapers/125.jpg .

# Copy GRUB themes
rm -rf boot

cp -r --parents /boot/grub/themes/* .

# Copy /etc config files
rm -rf etc

etc_subdirectories="greetd pam.d/greetd vtrgb"

for subdirectory in $etc_subdirectories; do
    cp -r --parents /etc/$subdirectory .
done

# Copy hacky fix for tuigreet
cp -r --parents /usr/lib/systemd/system/greetd.service.d/00-nobleed.conf .

# Change the user home name to a generic one
mv home/$(basename $HOME) home/user
