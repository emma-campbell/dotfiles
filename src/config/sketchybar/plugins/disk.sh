# !/usr/bin/env sh

sketchybar -m --set disk label=$(df -lh | grep /dev/disk1s2 | awk '{print $5}')