#!/usr/bin/env sh

sketchybar --add item clock right \
    --set clock \
    script="$PLUGINS/clock.sh" \
    icon=$CALENDAR \
    icon.color=$YELLOW \
    update_freq=60