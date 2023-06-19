#!/usr/bin/env sh

figlet -f small "CALICOMP  Updater"
echo -n "Proceed with the system update? (Y/n) "
read response
response=$(echo $response | tr "[:upper:]" "[:lower:]")

if [[ $response == "" ]] || [[ $response == "y" ]] || [[ $response == "yes" ]]; then
    paru -Syu
    flatpak update
    echo -n "System update finished, press Enter to exit... "
    read
fi
