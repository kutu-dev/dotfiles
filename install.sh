#!/usr/bin/env sh

if [[ -z $XDG_CONFIG_HOME ]]; then
    config_dir="$HOME/.config"
else
    config_dir=$XDG_CONFIG_HOME
fi

cat <<"END_ASCII"
  ___   _   _    ___ ___ ___  __  __ ___   ___         _        _ _          
 / __| /_\ | |  |_ _/ __/ _ \|  \/  | _ \ |_ _|_ _  __| |_ __ _| | |___ _ _ 
| (__ / _ \| |__ | | (_| (_) | |\/| |  _/  | || ' \(_-<  _/ _` | | / -_) '_|
 \___/_/ \_\____|___\___\___/|_|  |_|_|   |___|_||_/__/\__\__,_|_|_\___|_|  
    By Kutu - Version 0.1.0
END_ASCII

#TODO REMEMBER TO PRECONFIGURE GRUB
# Not working when downloading with curl

# while true; do
#     echo -n "Do you want to start with the installation? (Y/n) "
#     read start_installation_prompt

#     # User input to lowercase
#     start_installation_prompt=$(echo "$start_installation_prompt" | tr "[:upper:]" "[:lower:]")

#     if [[ $start_installation_prompt == "" || $start_installation_prompt == "y" || $start_installation_prompt == "yes" ]]; then
#         break
#     elif [[ $start_installation_prompt == "n" || $start_installation_prompt == "no" ]]; then
#         exit 0
#     fi

# done

trap 'rm -drf "$temporal_dir"' EXIT
temporal_dir=$(mktemp -d) || exit 1
cd $temporal_dir

# Install pacman packages
sudo pacman -Syu
sudo pacman -S --needed --noconfirm base-devel git greetd wl-clipboard pipewire wireplumber gnome-keyring polkit-kde-agent udiskie dunst swayidle geary qt5-wayland qt6-wayland xdg-user-dirs networkmanager

# Install paru

if ! command -v paru &> /dev/null; then
    git clone https://aur.archlinux.org/paru.git
    cd paru/
    makepkg -si
fi

# Install paru packages
paru -Syu
paru -S --needed --noconfirm --skipreview hyprland-nvidia-git ttf-ms-win11-auto xdg-desktop-portal-hyprland-git arrpc eww-wayland rofi-lbonn-wayland-git swaylock-effects waybar-hyprland-git

# Clone and apply dotfiles
git clone https://github.com/kutu-dev/dotfiles.git
cp -r dotfiles/home/kutu/.config/* $config_dir

# Apply GRUB theme
sudo cp -r dotfiles/boot/grub/* /boot/grub
sudo awk -i inplace '/GRUB_THEME=/ {gsub(/"[^"]+"/, "\"/boot/grub/themes/tokyo-night/theme.txt\"")} 1' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Start systemd services
sudo systemctl enable greetd.service

# Create default user directories
xdg-user-dirs-update
