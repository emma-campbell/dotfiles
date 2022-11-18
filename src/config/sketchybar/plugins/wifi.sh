#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

if [ "$SSID" = "" ]; then
  sketchybar --set wifi icon=$WIFI_OFF
  sketchybar --set wifi.speed label=")Mbps" icon=$SPEED
else
  sketchybar --set wifi.speed icon=$SPEED label="${CURR_TX}Mbps"
  sketchybar --set wifi.network icon=$NETWORK label="$SSID"
fi