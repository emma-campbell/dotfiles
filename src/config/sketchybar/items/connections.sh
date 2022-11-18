#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"

sketchybar --add item mic right \
    --set mic \
    icon=$MICROPHONE_ON

sketchybar --add item volume right \
    --set volume \
    icon=$SOUND_ON

# Bluetooth Indicator ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BLUETOOTH_POPUP_OFF=" sketchybar --set bluetooth popup.drawing=off"

sketchybar --add item bluetooth right
sketchybar --set bluetooth \
    click_script="sketchybar --set bluetooth popup.drawing=toggle" \
    script="$PLUGINS/bluetooth.sh" \
    update_freq=5

sketchybar --add item bluetooth.toggle popup.bluetooth 
sketchybar --set bluetooth.toggle icon=$POWER \
    label="Toggle Bluetooth" \
    click_script="$SCRIPTS/toggle_bluetooth.sh; $PLUGINS/bluetooth.sh; $BLUETOOTH_POPUP_OFF"

sketchybar --add item bluetooth.discover popup.bluetooth 
sketchybar --set bluetooth.discover icon=$PREFERENCES \
    label="Bluetooth Settings" \
    click_script="open /System/Library/PreferencePanes/Bluetooth.prefPane/; $BLUETOOTH_POPUP_OFF"

# WIFI Indicator ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sketchybar --add item wifi right \
    --set wifi \
    click_script="sketchybar --set wifi popup.drawing=toggle" \
    icon.padding_left=10 \
    icon=$WIFI_ON

sketchybar --add item wifi.network popup.wifi
sketchybar --add item wifi.speed popup.wifi \
    --set wifi.speed \
    script="$PLUGINS/wifi.sh" \
    updates=when_shown \
    update_freq=5

sketchybar --add item wifi.settings popup.wifi \
    --set wifi.settings \
    icon=$PREFERENCES \
    label="Network Settings" \
    click_script=" open /System/Library/PreferencePanes/Network.prefPane/; sketchybar --set wifi popup.drawing=off"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sketchybar --add bracket connections mic volume bluetooth wifi
sketchybar --set connections \
    background.padding_left=10 \
    background.padding_right=10 \
    background.color="$BLACK" \
    background.height=30 \
    background.border_color="$DARK_OUTLINE" \
    background.border_width=2
