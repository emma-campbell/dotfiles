#!/usr/bin/env sh

source "$HOME/.config/sketchybar/utils.sh"

sketchybar --add item clock right \
    --set clock \
    script="$PLUGINS/clock.sh" \
    label.font="$FONT:Bold:14" \
    icon=$CALENDAR \
    icon.color=$YELLOW \
    update_freq=60