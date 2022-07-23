#!/bin/sh
#echo "$(df -h | awk 'NR==4{ print $4, "free", $5, "used" }')"
#hdd=$(df -h | awk 'NR==4{ print $4, "free", $5, "used" }')
#printf " %s " "$hdd"

date '+%a, %b %d,%l:%M%p' > ~/.curtime.tmp

while true; do

        date '+%a, %b %d,%l:%M%p' > ~/.curtime.tmp
        #date '+| %A :: %B %d :: %R |' > ~/.curtime.tmp

        sleep 60s
done &

while true; do

        LOCALTIME=$(cat ~/.curtime.tmp)
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

        xsetroot -name "$(printf "\x02 %s   \x01  %s     %s     cpu: %s   \x03  %s pkgs: %s " "$LOCALTIME" "$HDD" "$MEM" "$CPU" "$LINUX" "$UPDATES")"

        sleep 10s
done &
