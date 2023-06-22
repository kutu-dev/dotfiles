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

# Since Nvidia drivers in non Nvidia hardware can crash
while true; do
    echo -n "Are you using a Nvidia graphics card? (Y/n) "
    read using_nvidia_prompt

    # User input to lowercase
    using_nvidia_prompt=$(echo "$using_nvidia_prompt" | tr "[:upper:]" "[:lower:]")

    if [[ $using_nvidia_prompt == "" || $using_nvidia_prompt == "y" || $using_nvidia_prompt == "yes" ]]; then
        using_nvidia=true
        break
    elif [[ $using_nvidia_prompt == "n" || $using_nvidia_prompt == "no" ]]; then
        using_nvidia=false
        break
    fi
done

# Install paru
if ! command -v paru &> /dev/null; then
    sudo pacman -S base-devel rustup
    rustup default stable
    git clone https://aur.archlinux.org/paru.git
    cd paru/
    makepkg -si
    sudo pacman -Runs rustup
    cd ..
fi

# Active multilib repository
sudo sed -i '/\[multilib\]/ {s/#//g;n;s/#//g}' /etc/pacman.conf

# Install all packages
paru -Syu
paru -S $(awk '{print $1}' packages.txt)

if [[ $using_nvidia == true ]]; then
    # Install Nvidia specific packages
    paru -S nvidia libva-nvidia-driver libva lib32-nvidia-utils hyprland-nvidia-git
else
    paru -S hyprland
    
    # Remove unnecessary configurations from Hyprland config
    sed -i -e '/#.*Nvidia.*/d' \
    -e '/.*LIBVA_DRIVER_NAME.*/d' \
    -e '/.*XDG_SESSION_TYPE.*/d' \
    -e '/.*GBM_BACKEND.*/d' \
    -e '/.*__GLX_VENDOR_LIBRARY_NAME.*/d' \
    -e '/.*WLR_NO_HARDWARE_CURSORS.*/d' \
    home/kutu/.config/hypr/env.conf
fi

# Copy non hidden directories and files
cp -r home/kutu/* ~

# Apply the dotfiles
mkdir -p $config_dir
cp -r home/kutu/.config/* $config_dir

mkdir -p  $local_dir
cp -r home/kutu/.local/* $local_dir

cp -r home/kutu/.local/* $local_dir

cp -r home/kutu/.face ~

# Apply GTK themes
cp -r home/kutu/.themes ~

# Apply GTK 4 theme
cp -r home/kutu/.themes/tokyo-night/gtk-4.0 $config_dir

# Apply Mozilla dotfiles
cp -r home/kutu/.mozilla/* ~/.mozilla

# Apply GRUB theme
sudo cp -r boot/grub/* /boot/grub

# Apply VSCodium extensions
xargs -a vscodium-extensions.txt -L 1 vscodium --install-extension

# To avoid crashes at boot as the GRUB theme is only 1080p compatible
while true; do
    echo -n "Are all your displays 1080p resolution? (Y/n) "
    read display_valid_resolution

    # User input to lowercase
    display_valid_resolution=$(echo "$display_valid_resolution" | tr "[:upper:]" "[:lower:]")

    if [[ $display_valid_resolution == "" || $display_valid_resolution == "y" || $display_valid_resolution == "yes" ]]; then
        sudo sed -i '/GRUB_THEME/ {s/#//g;s/\/path\/to\/gfxtheme/\/boot\/grub\/themes\/calicomp\/theme.txt/g}' /etc/default/grub
        break
    elif [[ $display_valid_resolution == "n" || $display_valid_resolution == "no" ]]; then
        break
    fi
done

sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT/ s/".*"/"loglevel=4 nvidia_drm.modeset=1"/g' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Apply /etc configs
sudo cp -r etc/* /etc

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

# Add default wallpaper
cp -r home/kutu/pictures/wallpapers ~/pictures

# Change the Spicetify prefs path to match user home directory name
# Use pipes instead of slashes to avoid syntax errors with the path inside $HOME
sed -i "s|/home/kutu|$HOME|g" .config/spicetify/config-xpui.ini

# Add custom mkinitcpio hooks and modules
sudo sed -i '/^HOOKS=/ s/keymap/keymap setvtrgb consolefont numlock/g' /etc/mkinitcpio.conf

if [[ $using_nvidia == true ]]; then
    sudo sed -i '/^MODULES=/ s/(/(nvidia nvidia_modeset nvidia_uvm nvidia_drm/g' /etc/mkinitcpio.conf
fi

sudo mkinitcpio -p linux
