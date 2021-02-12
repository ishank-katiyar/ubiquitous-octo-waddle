#!/bin/bash

notify-send.py a --hint boolean:deadd-notification-center:true \
               string:type:clearPopups

if [ "$1" == "inc" ]; then
   amixer -q sset Master 5%+
fi

if [ "$1" == "dec" ]; then
   amixer -q sset Master 5%-
fi

if [ "$1" == "mute" ]; then
   amixer -q sset Master toggle
fi


AMIXER=$(amixer sget Master)
VOLUME=$(echo $AMIXER | grep 'Right:' | awk -F'[][]' '{ print $2 }' | tr -d "%")
MUTE=$(echo $AMIXER | grep -o '\[off\]' | tail -n 1)
if [ "$VOLUME" -le 20 ]; then
    ICON=audio-volume-low
else if [ "$VOLUME" -le 60 ]; then
         ICON=audio-volume-medium
     else 
         ICON=audio-volume-high
     fi
fi
if [ "$MUTE" == "[off]" ]; then
    ICON=audio-volume-muted
    VOLUME=0
    A="(MUTE)"
fi 



NOTI_ID=$(notify-send.py "VOLUME" "$VOLUME%$A" \
    --hint int:value:$VOLUME)
                         # --hint string:image-path:$ICON boolean:transient:true \
                                # int:has-percentage:$VOLUME \
                         # --replaces-process "volume-popup")
