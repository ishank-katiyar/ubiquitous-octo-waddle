current_mode=$(cat /home/ishank/.config/i3/some_scripts/get_status_bar_mode.txt)

if [[ "$current_mode" == "" ]]
then 
    echo "dock" > /home/ishank/.config/i3/some_scripts/get_status_bar_mode.txt
    echo "dock"
elif [[ "$current_mode" == "dock" ]]
then 
    echo "hide"
    echo "hide" > /home/ishank/.config/i3/some_scripts/get_status_bar_mode.txt
elif [[ "$current_mode" == "hide" ]]
then 
    echo "dock"
    echo "dock" > /home/ishank/.config/i3/some_scripts/get_status_bar_mode.txt
else 
    echo "nothing"
fi
