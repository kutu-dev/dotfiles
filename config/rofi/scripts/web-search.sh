#!/usr/bin/env sh

if [[ -z "$@" ]]
then
    exit 0
fi

xdg-open "https://duckduckgo.com/?q=$1" &