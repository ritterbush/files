#!/bin/sh

alacrittyrc_path="$HOME"/.config/alacritty/alacritty.yml

#Check that argument is a number
case $1 in
    ''|*[!0-9]*) # Also guards against no arguments given; error given if handled below
        { echo "$0 accepts numbers 0-100 only."; exit 1; }
        ;;
esac

if [ ${#1} -eq 1 ]
then
    sed -i "s/opacity:.*/opacity: 0.0$1/" "$alacrittyrc_path"
    exit
elif [ ${#1} -eq 2 ]
then
    sed -i "s/opacity:.*/opacity: 0.$1/" "$alacrittyrc_path"
    exit
elif [ ${#1} -eq 3 ]
then
    sed -i "s/opacity:.*/opacity: 1.0/" "$alacrittyrc_path"
    exit
fi

echo "$0 accepts numbers 0-100 only."
exit 1
