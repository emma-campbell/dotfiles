# !/usr/bin/env sh

TOGGLE=$(blueutil -p)

if [[ $TOGGLE = 1 ]]; then
    blueutil -p 0
else
    blueutil -p 1
fi

sketchybar --set bluetooth popup.drawing=off
