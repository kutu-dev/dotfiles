#!/usr/bin/env sh

# Avoid notification sound in Spotify and Discord
if [[ $1 != "Spotify" && $1 != "org.gnome.Nautilus" ]]; then
    play ~/.config/dunst/notification-sound.opus
fi
