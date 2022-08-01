#!/bin/sh

#echo "$(df -h | awk 'NR==4{ print $4, "free", $5, "used" }')"
#hdd=$(df -h | awk 'NR==4{ print $4, "free", $5, "used" }')
#printf " %s " "$hdd"

#date '+%a, %b %d,%l:%M%p' > $HOME/.curtime.tmp

while true
do
    date '+%a, %b %d,%l:%M%p' > $HOME/.curtime.tmp
    #date '+| %A :: %B %d :: %R |' > $HOME/.curtime.tmp
    sleep 60s
done &

while true
do
    #DISKROOT=$(df -Ph | grep "/dev/sda1" | awk {'print $5'})
    #DISKHOME=$(df -Ph | grep "/dev/sda2" | awk {'print $5'})
    HDD=$(df -h | awk 'NR==4{ print $4, "free", $5, "used" }')
    MEM=$(free -h --kilo | awk '/^Mem:/ {print $3 " / " $2}')
    LINUX=$(uname -r)
    UPDATES=$(pacman -Qu | wc -l)
    #TOTALDOWN=$(sudo ifconfig wlan0 | grep "RX packets" | awk {'print $6 $7'})
    #TOTALUP=$(sudo ifconfig wlan0 | grep "TX packets" | awk {'print $6 $7'})
    CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
    #WEATHER=$(curl wttr.in/Brisbane?format="%l:+%m+%p+%w+%t+%c+%C")
    LOCALTIME=$(cat $HOME/.curtime.tmp) # Place this last to help ensure that the curtime file is made in the first loop; other attempts with placing the command of the first loop before the loops, or with delays were inconsistent (2s delay might work, but this is slow)

    xsetroot -name "$(printf "\x01 %s   \x02  %s     %s     cpu: %s   \x03  %s pkgs: %s " "$LOCALTIME" "$HDD" "$MEM" "$CPU" "$LINUX" "$UPDATES")"

    sleep 10s
done &
