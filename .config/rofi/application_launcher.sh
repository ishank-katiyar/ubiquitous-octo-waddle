#!/bin/bash

#
# Powermenu for Rofi
# 
# Author : Lucero Alvarado
# Github : @lu0
#

# Fake blurred background
# SS_PATH="$HOME/.config/rofi/screenshot"
# rm -f "${SS_PATH}.jpg" && scrot -z "${SS_PATH}.jpg"                 # screenshot
# convert "${SS_PATH}.jpg" -blur 0x10 -auto-level "${SS_PATH}.jpg"    # blur
# convert "${SS_PATH}.jpg" "${SS_PATH}.png"                           # rofi reads png images
sed -i '163s/.*/blur-strength = 8;/' ~/.config/picom/picom.conf

# Font size according to screen dimensions
DEFAULT_WIDTH=1920
WIDTH=$(xdpyinfo | grep dimensions | awk '{print $2}' | cut -d 'x' -f 1 )
DEFAULT_FONTSIZE=12

rofi -show drun -show-icons -theme application_launcher.rasi \
# -fake-background ${SS_PATH}.png -fake-transparency \
-font "Hack, $DEFAULT_FONTSIZE" \


sed -i '163s/.*/blur-strength = 5;/' ~/.config/picom/picom.conf
