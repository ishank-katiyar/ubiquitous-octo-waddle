# notify-send "running"
# out=`killall plank 2>&1 > /dev/null`
# echo $out
PID=`pgrep plank`
echo $PID
if [[ $PID ]]
then 
    kill $PID
else 
    plank& 2>&1 > /dev/null
fi
