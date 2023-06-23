function update --description "Update pacman packages, AUR packages and flatpak apps"
    command paru -Syu
    command flatpak update
end