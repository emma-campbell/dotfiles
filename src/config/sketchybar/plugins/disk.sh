# !/usr/bin/env sh

sketchybar --set $NAME \
    label=$(df -lh | grep /dev/disk1s2 | awk '{print $5}')