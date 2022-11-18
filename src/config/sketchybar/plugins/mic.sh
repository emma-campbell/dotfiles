# !/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [[ $MIC_VOLUME -eq 0 ]]; then
    sketchybar -m --set mic icon=$MICROPHONE_OFF icon.color=$RED
elif [[ $MIC_VOLUME -gt 0 ]]; then
    sketchybar -m --set mic icon=$MICROPHONE_ON icon.color=$WHITE
fi
