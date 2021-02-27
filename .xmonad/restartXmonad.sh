xmonad --recompile

echo "compiled...."

if [ -s ~/.xmonad/xmonad.errors ]
then
    alacritty --hold -e cat ~/.xmonad/xmonad.errors &
else
    xdotool key super+q
fi
