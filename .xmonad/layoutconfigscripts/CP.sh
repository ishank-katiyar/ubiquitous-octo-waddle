cpworkspace=8
sleeptime=0.5

echo $#
if [ $# -et 0 ]
then
    firefox -new-window &
    sleep ${sleeptime}s 
    xdotool key super+shift+${cpworkspace} 
    xdotool key super+${cpworkspace} 
    alacritty -e vifm &
    sleep ${sleeptime}s 
    # notify-send "ok"
    xdotool key super+shift+j
else 
    firefox -new-window $1 &
    sleep ${sleeptime}s
    xdotool key super+shift+${cpworkspace}
    xdotool key super+${cpworkspace}
    alacritty -e vifm &
    sleep ${sleeptime}s
    # notify-send "ok"
    xdotool key super+shift+j
fi
