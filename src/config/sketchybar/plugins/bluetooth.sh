# !/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"

BLUETOOTH=$(blueutil -p)

if [[ BLUETOOTH -eq 1 ]]; then
    ICON=$BLUETOOTH_ON
    echo "ON"
else
    ICON=$BLUETOOTH_OFF
    echo "OFF"
fi

sketchybar --set $NAME icon="$ICON"