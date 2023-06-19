#!/usr/bin/env sh

if [[ -z $XDG_CONFIG_HOME ]]; then
    config_dir="$HOME/.config"
else
    config_dir=$XDG_CONFIG_HOME
fi

if [[ -z $XDG_DATA_HOME ]]; then
    local_dir="$HOME/.local"
else
    local_dir=$XDG_CONFIG_HOME
fi

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

cp packages.txt $temporal_dir
cd $temporal_dir

# Install paru

if ! command -v paru &> /dev/null; then
    sudo pacman -S base-devel cargo
    git clone https://aur.archlinux.org/paru.git
    cd paru/
    makepkg -si
    sudo pacman -Runs cargo
fi

# Install all packages
paru -Syu
sudo paru -S $(awk '{print $1}' packages.txt)

# Clone and apply dotfiles
git clone https://github.com/kutu-dev/dotfiles.git

mkdir -p $config_dir
cp -r dotfiles/home/kutu/.config/* $config_dir

mkdir -p  $local_dir
cp -r dotfiles/home/kutu/.local/* $local_dir

# Add user profile picture
cp -r dotfiles/home/kutu/.face ~

# Apply GTK themes
cp -r dotfiles/home/kutu/.themes ~

# Apply GTK 4 theme
cp -r dotfiles/home/kutu/.themes/tokyo-night/gtk-4.0 $config_dir

# Apply GRUB theme
sudo cp -r dotfiles/boot/grub/* /boot/grub
sudo awk -i inplace '/GRUB_THEME=/ {gsub(/"[^"]+"/, "\"/boot/grub/themes/calicomp/theme.txt\"")} 1' /etc/default/grub
sudo awk -i inplace '/GRUB_THEME=/ {gsub("#", "")} 1' /etc/default/grub
sudo awk -i inplace '/GRUB_CMDLINE_LINUX_DEFAULT=/ {gsub("quiet", "")} {gsub("loglevel=3", "loglevel=4")} 1' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Apply /etc configs
sudo cp -r dotfiles/etc/* /etc

# Start systemd services
sudo systemctl enable greetd
sudo systemctl enable NetworkManager
systemctl enable --user pipewire-pulse

# Create default user directories
mkdir -p ~/desktop
mkdir -p ~/downloads
mkdir -p ~/templates
mkdir -p ~/public
mkdir -p ~/documents
mkdir -p ~/music
mkdir -p ~/pictures
mkdir -p ~/videos
xdg-user-dirs-update

# I don't know why this is installed
sudo pacman -Runs xdg-desktop-portal-kde

# Add wallpapers
cp -r --parents dotfiles/home/kutu/pictures/wallpapers ~
