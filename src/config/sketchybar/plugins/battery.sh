#!/usr/bin/env sh

source $HOME/.config/sketchybar/colors.sh

FONT="Lilex Nerd Font"
PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

case ${PERCENTAGE} in
9[0-9] | 100) ICON="" COLOR=$GREEN ;;
[6-8][0-9]) ICON="" COLOR=$GREEN ;;
[3-5][0-9]) ICON="" COLOR=$YELLOW ;;
[1-2][0-9]) ICON="" COLOR=$RED ;;
*) ICON="" COLOR=$RED ;;
esac

if [[ $CHARGING != "" ]]; then
  ICON=""
  COLOR=$GREEN
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set $NAME \
  icon="$ICON" \
  icon.font="$FONT:Bold:14" \
  icon.color="$COLOR" \
  label="${PERCENTAGE}%" \
  label.font="$FONT:Bold:14.0"
