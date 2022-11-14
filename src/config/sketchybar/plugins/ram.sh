# !/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"

USAGE=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100-$5"%"}')

case ${USAGE} in
9[0-9] | 100)
    COLOR=$RED
    ;;
[6-8][0-9])
    COLOR=$YELLOW
    ;;
[3-5][0-9])
    COLOR=$GREEN
    ;;
[1-2][0-9])
    COLOR=$GREEN
    ;;
*) COLOR=$GREEN ;;
esac

sketchybar -m --set ram \
    label=$USAGE icon.color=$COLOR
