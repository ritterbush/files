#!/bin/sh

alacrittyrc_path=$HOME/.config/alacritty/alacritty.yml

#Check that argument is a number
if [ -z "${1##*[!0-9]*}" ] # Parameter expansion on $1, where '#' chops it up from matches that follow
then
    echo "Numbers 0-100 only."
    exit 1
fi

if [ ${#1} -eq 1 ]
then
    sed -i "s/opacity:.*/opacity: 0.0$1/" $alacrittyrc_path
elif [ ${#1} -eq 2 ]
then
    sed -i "s/opacity:.*/opacity: 0.$1/" $alacrittyrc_path
elif [ ${#1} -eq 3 ]
then
    sed -i "s/opacity:.*/opacity: 1.0/" $alacrittyrc_path
fi
