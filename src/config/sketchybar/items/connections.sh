#!/usr/bin/env sh

# WIFI Indicator ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sketchybar --add item wifi right \
    --set wifi \
        click_script="sketchybar --set wifi popup.drawing=toggle" \
        icon.padding_left=10 \
        icon=直


sketchybar --add bracket connections wifi
sketchybar --set connections \
    background.padding_left=10 \
    background.padding_right=10 \
    background.color="$BLACK" \
    background.height=30 \
    background.border_color="$DARK_OUTLINE" \
    background.border_width=2 
