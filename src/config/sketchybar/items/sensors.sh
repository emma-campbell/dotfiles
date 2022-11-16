#!/usr/bin/env sh

# SYSTEM STATISTICS -----------------------------------------------------
# -----------------------------------------------------------------------

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

# DISK ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sketchybar --add item disk right
sketchybar --set disk label.font="$FONT:Bold:12" \
    icon="$DISK" \
    icon.color="$BLUE" \
    update_freq=2 \
    script="$PLUGINS/disk.sh"

# CPU ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sketchybar --add item cpu right
sketchybar --set cpu label.font="$FONT:Bold:12" \
    icon="$CPU" \
    icon.color="$BLUE" \
    update_freq=2 \
    script="$PLUGINS/cpu.sh"

# NETWORK ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sketchybar --add item network_up right
sketchybar --set network_up \
    label.align="right" \
    label.font="$FONT:Bold:9" \
    icon.font="$FONT:BOLD:10" \
    icon=$UPLOAD \
    icon.color=$BLUE \
    y_offset=5 \
    width=0 \
    update_freq=1 \
    script="$PLUGINS/network.sh"

sketchybar --add item network_down right
sketchybar --set network_down \
    label.align="right" \
    label.font="$FONT:Bold:9" \
    icon.font="$FONT:Bold:10" \
    icon=$DOWNLOAD \
    icon.color=$RED \
    y_offset=-5

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Add DISK and CPU to Bracket
sketchybar --add bracket sensors disk cpu network_up network_down
sketchybar --set sensors \
    background.padding_left=10 \
    background.padding_right=10 \
    background.color="$BLACK" \
    background.height=30 \
    background.border_color="$DARK_OUTLINE" \
    background.border_width=2 