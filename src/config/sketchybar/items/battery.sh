#!/usr/bin/env sh

# Battery Indicator ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sketchybar --add item battery right \
    --set battery \
        script="$PLUGINS/battery.sh" \
        update_freq=5