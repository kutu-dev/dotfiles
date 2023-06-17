#!/usr/bin/env sh

modes="Browse files <i><small>(F)</small></i>\0icon\x1ffolder|Search on internet <i><small>(S)</small></i>\0icon\x1femblem-web|Search Emoji <i><small>(E)</small></i>\0icon\x1fface-smile-big|Connect with SSH <i><small>(C)</small></i>\0icon\x1fnetwork-server|Run command <i><small>(R)</small></i>\0icon\x1futilities-terminal|Toggle caffeine <i><small>(T)</small></i>\0icon\x1fdisplay-brightness"

mode=$(echo -en $modes | rofi -dmenu -markup-rows -sep "|" -p "")

if [[ $mode = "Browse files <i><small>(F)</small></i>" ]]; then
    rofi -show file-browser-extended -file-browser-dir ~
elif [[ $mode = "Search on internet <i><small>(S)</small></i>" ]]; then
    rofi -show web-search
elif [[ $mode = "Search Emoji <i><small>(E)</small></i>" ]]; then
    rofimoji --prompt ☻
elif [[ $mode = "Connect with SSH <i><small>(C)</small></i>" ]]; then
    rofi -show ssh
elif [[ $mode = "Run command <i><small>(R)</small></i>" ]]; then
    rofi -show run
elif [[ $mode = "Toggle caffeine <i><small>(T)</small></i>" ]]; then
    sh ~/.config/hypr/scripts/caffeine-toggle.sh
else
    exit 1
fi
