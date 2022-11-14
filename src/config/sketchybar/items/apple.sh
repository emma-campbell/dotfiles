#!/usr/bin/env sh
source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/utils.sh"

POPUP_OFF="sketchybar --set apple.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

# Apple Logo
sketchybar --add item apple.logo left
sketchybar --set apple.logo icon="$APPLE" \
    icon.font="$FONT:Bold:18.0" \
    label.drawing=off \
    click_script="$POPUP_CLICK_SCRIPT"

# Prefrences Option
sketchybar --add item apple.prefs popup.apple.logo
sketchybar --set apple.prefs icon=$PREFERENCES \
    icon.padding_left=10 \
    label.padding_right=10 \
    label="Preferences" \
    click_script="open -a 'System Preferences'; $POPUP_OFF"

# Activity Option
sketchybar --add item apple.activity popup.apple.logo
sketchybar --set apple.activity icon=$ACTIVITY \
    icon.padding_left=10 \
    label.padding_right=10 \
    label="Activity" \
    click_script="open -a 'Activity Monitor'; $POPUP_OFF"

# Force Quit Option
sketchybar --add item apple.force_quit popup.apple.logo
sketchybar --set apple.force_quit icon=$FORCE_QUIT \
    icon.padding_left=10 \
    label.padding_right=10 \
    label="Force Quit" \
    click_script="osascript -e 'tell application \"System Events\" to key code 53 using {command down, option down}';
                                                    $POPUP_OFF"

# Lock Screen
sketchybar --add item apple.lock popup.apple.logo
sketchybar --set apple.lock icon=$LOCK \
    icon.padding_left=10 \
    label.padding_right=10 \
    label="Lock Screen" \
    click_script="pmset displaysleepnow; $POPUP_OFF"
