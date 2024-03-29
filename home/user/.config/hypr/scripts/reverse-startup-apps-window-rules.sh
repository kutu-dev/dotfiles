#!/usr/bin/env sh

steam_windows_opened=0

handle() {
    case $1 in
        openwindow\>\>*,*,firefox,*)
            hyprctl keyword windowrulev2 "workspace unset, class:firefox"
        ;;

        openwindow\>\>*,*,Spotify,*)
            hyprctl keyword windowrulev2 "workspace unset, class:Spotify"
        ;;

        openwindow\>\>*,*,steam,*)
            # Avoid unsetting the window rule when the Steam update popup appears
            if [[ $steam_windows_opened -eq 2 ]]; then
                hyprctl keyword windowrulev2 "workspace unset, class:steam"
            else
                steam_windows_opened=$((steam_windows_opened+1))
            fi
        ;;
    esac
}

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
