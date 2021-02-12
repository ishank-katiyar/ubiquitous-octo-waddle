#!/bin/bash

#
# Powermenu for Rofi
# 
# Author : Lucero Alvarado
# Github : @lu0
#

# Options as characters
# Copied from decoded unicodes (private use of "Feather" font)
shutdown="";        # "\uE9C0"
reboot="";          # "\uE9C4"
sleep="";           # "\uE9A3"
logout="";          # "\uE991"
lock="";            # "\uE98F"
options="$shutdown\n$reboot\n$sleep\n$logout\n$lock"

# Fake blurred background
# SS_PATH="$HOME/.config/rofi/screenshot"
# rm -f "${SS_PATH}.jpg" && scrot -z "${SS_PATH}.jpg"                 # screenshot
# convert "${SS_PATH}.jpg" -blur 0x10 -auto-level "${SS_PATH}.jpg"    # blur
# convert "${SS_PATH}.jpg" "${SS_PATH}.png"                           # rofi reads png images

# Font size according to screen dimensions
DEFAULT_WIDTH=1920
WIDTH=$(xdpyinfo | grep dimensions | awk '{print $2}' | cut -d 'x' -f 1 )
DEFAULT_FONTSIZE=60
FONTSIZE=$(echo "$WIDTH/$DEFAULT_WIDTH*$DEFAULT_FONTSIZE" | bc -l)

while getopts "lp" OPT; do
    case "$OPT" in
        p) PRESELECTION=0 ;;
        l) PRESELECTION=3 ;;
        *) PRESELECTION=4 ;;
    esac
done
if (( $OPTIND == 1 )); then
   PRESELECTION=4
fi

# echo $SS_PATH
# echo $FONTSIZE
# echo $LOGNAME
# echo $PRESELECTION
# PRESELECTION=0
# echo $PRESELECTION
                 # -fake-background ${SS_PATH}.png -fake-transparency \

# sed -i '163s/.*/blur-strength = 8;/' ~/.config/picom/picom.conf

selected="$(echo -e "$options" | 
            rofi -show-icons -theme powermenu_theme.rasi \
                 -font "WeblySleek UI Light, $FONTSIZE" \
                 -p "See you later, ${LOGNAME^}!" -dmenu -selected-row ${PRESELECTION})"

case $selected in

    $shutdown)
        # sed -i '163s/.*/blur-strength = 5;/' ~/.config/picom/picom.conf
        systemctl poweroff
        ;;

    $reboot)
        # sed -i '163s/.*/blur-strength = 5;/' ~/.config/picom/picom.conf
        systemctl reboot
        ;;

    $sleep)
        # sed -i '163s/.*/blur-strength = 5;/' ~/.config/picom/picom.conf
        systemctl suspend
        ;;

    $logout)
        # cinnamon-session-quit --logout --no-prompt || ( xfce4-session-logout --logout || mate-session-save --logout )
        # systemctl restart lightdm
        # sed -i '163s/.*/blur-strength = 5;/' ~/.config/picom/picom.conf
        # killall xmonad
        notify-send "Cannot logout xmonad"
        ;;

    $lock)
        # sed -i '163s/.*/blur-strength = 5;/' ~/.config/picom/picom.conf
        i3lock
        ;;
    *)
        # sed -i '163s/.*/blur-strength = 5;/' ~/.config/picom/picom.conf
        ;;

esac
