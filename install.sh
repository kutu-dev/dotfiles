#!/usr/bin/env sh

cat <<"END_ASCII"
  ___   _   _    ___ ___ ___  __  __ ___   ___         _        _ _          
 / __| /_\ | |  |_ _/ __/ _ \|  \/  | _ \ |_ _|_ _  __| |_ __ _| | |___ _ _ 
| (__ / _ \| |__ | | (_| (_) | |\/| |  _/  | || ' \(_-<  _/ _` | | / -_) '_|
 \___/_/ \_\____|___\___\___/|_|  |_|_|   |___|_||_/__/\__\__,_|_|_\___|_|  
    By Kutu - Version 0.1.0
END_ASCII

while true; do
    echo -n "Do you want to start with the installation? (Y/n) "
    read start_installation_prompt

    # User input to lowercase
    start_installation_prompt=$(echo "$start_installation_prompt" | tr "[:upper:]" "[:lower:]")

    if [[ $start_installation_prompt == "" || $start_installation_prompt == "y" || $start_installation_prompt == "yes" ]]; then
        break
    elif [[ $start_installation_prompt == "n" || $start_installation_prompt == "no" ]]; then
        exit 0
    fi

done

trap 'rm -drf "$temporal_dir"' EXIT
temporal_dir=$(mktemp -d) || exit 1
cd $temporal_dir

# Install pacman packages
sudo pacman -S --needed base-devel git

# Install paru
echo git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# Install paru packages
paru -S --needed PAQUETES

# Clone and apply dotfiles
git clone https://github.com/kutu-dev/dotfiles.git

