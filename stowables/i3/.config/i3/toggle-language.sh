#!/usr/bin/env bash

selected=$(echo "us
il" | rofi -dmenu -p "Select Keyboard Layout" -l 2)

setxkbmap -layout $selected

# Refresh language in i3 blocks. `10` is the signal number of the laguage block
pkill -SIGRTMIN+10 i3blocks