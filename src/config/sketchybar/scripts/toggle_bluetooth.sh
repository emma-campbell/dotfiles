# !/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"

TOGGLE=$(blueutil -p)

if [[ $TOGGLE = 1 ]]; then
    blueutil -p 0
    ICON=$BLUETOOTH_OFF
else
    blueutil -p 1
    ICON=$BLUETOOTH_ON
fi

sketchybar --set bluetooth popup.drawing=off icon=$ICON
