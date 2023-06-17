#!/usr/bin/env sh

if pgrep -x "swayidle" > /dev/null; then
    echo 󰾪
else
    echo 󰅶
fi
