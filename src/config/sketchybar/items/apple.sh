#!/usr/bin/env sh
source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/utils.sh"

POPUP_OFF="sketchybar --set apple.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar  --add item              apple.logo left \ 
            --set apple.logo        icon="$APPLE" \
                                    background.padding_right=25 \
                                    label.drawing=off \
                                    click_script="$POPUP_CLICK_SCRIPT" \
    
            --add item              apple.prefs popup.apple.logo \
            --set apple.prefs       icon=$PREFERENCES \
                                    label="Preferences" \
                                    click_script="open -a 'System Preferences';
                                                $POPUP_OFF" \
            --add item              apple.activity popup.apple.logo \
            --set apple.activity    icon=$ACTIVITY \
                                    label="Activity" \
                                    click_script="open -a 'Activity Monitor';
                                                    $POPUP_OFF" \
            --add item              apple.force_quit popup.apple.logo \
            --set apple.force_quit  icon=$FORCE_QUIT \
                                    label="Force Quit" \
                                    click_script="osascript -e 'tell application \"System Events\" to key code 53 using {command down, option down}';
                                                    $POPUP_OFF" \
            --add item              apple.lock popup.apple.logo \
            --set apple.lock        icon=$LOCK \
                                    label="Lock Screen" \
                                    click_script="pmset displaysleepnow;
                                                    $POPUP_OFF"
