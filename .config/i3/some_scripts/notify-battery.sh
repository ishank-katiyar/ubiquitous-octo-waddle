#!/bin/bash

BATTINFO=`acpi -b | awk 'NR==1{print $0}'`
DIS=`echo $BATTINFO | grep Discharging`
CDIS=`echo $BATTINFO | grep Charging`
BAT=$(acpi -b | awk 'NR==1{print substr($4, 1, 2)}')
echo $DIS
echo $BAT
if [[ `echo $BAT | awk 'NR==1{print substr($1,2,2)}'` == "%" ]] ; then
    echo "single no"
    BAT=`acpi -b | awk 'NR==1{print substr($4, 1, 1)}'`
fi
echo $BAT
if [[ $DIS && $BAT -lt 20 ]] ; then
    DISPLAY=:0.0 /usr/bin/notify-send -u critical -t 3600000 "low battery" "$BATTINFO"
elif [[ $CDIS && $BAT -gt 95 ]] ; then
    DISPLAY=:0.0 /usr/bin/notify-send "full battery" "$BATTINFO"
fi
