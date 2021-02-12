#!/bin/bash


notify-send.py a --hint boolean:deadd-notification-center:true \
               string:type:clearPopups


if [ "$1" == "inc" ]; then
    brightnessctl set +5%
fi

if [ "$1" == "dec" ]; then
    brightnessctl set 5%-
fi

BRIGHTNESS=$(brightnessctl get)
BRIGHTNESSMAX=$(brightnessctl max)
echo $BRIGHTNESS
echo $BRIGHTNESSMAX
BRIGHTNESS=$((BRIGHTNESS * 100 / BRIGHTNESSMAX))
echo $BRIGHTNESS
NOTI_ID=$(notify-send.py "BRIGHTNESS" "$BRIGHTNESS%" \
                         --hint int:value:$BRIGHTNESS)
# --hint string:image-path:video-display boolean:transient:true \
# int:has-percentage:$BRIGHTNESS)
# --replaces-process "brightness-popup")
