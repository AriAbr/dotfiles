#!/usr/bin/env bash
source ~/.screenlayout/$(ls -A ~/.screenlayout | LANG=C sort | rofi -dmenu -p "Screen Layout" -l 10)