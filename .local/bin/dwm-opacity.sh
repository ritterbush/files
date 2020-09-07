#! /bin/sh

#Seds new opacity value to dwm after converting it into its equivalent hex and then rebuilds dwm.
#Could also add a restart to dwm at the end, but I prefer the control of restarting dwm with the hotkeys
#I might do it anyway

#Check that argument is a number
[[ $1 =~ ^-?[0-9]+$ ]] &&

percent_of_255="$(($1 * 255 / 100))" &&
#echo "$percent_of_255" &&
percent_of_255_hex=$(printf "%x\n" "$percent_of_255") &&
#echo "$percent_of_255_hex" &&

if [ ${#percent_of_255_hex} -eq 1 ]
    then 
        sed -i "s/static const unsigned int baralpha = .*/static const unsigned int baralpha = 0x0${percent_of_255_hex};/" "$HOME"/Programs/dwm/config.def.h
elif [ ${#percent_of_255_hex} -eq 2 ]
    then
        sed -i "s/static const unsigned int baralpha = .*/static const unsigned int baralpha = 0x${percent_of_255_hex};/" "$HOME"/Programs/dwm/config.def.h
fi &&

#sed "s/static const unsigned int baralpha = .*/static const unsigned int baralpha = 0x${1};/" "$HOME"/Programs/dwm/config.def.h

#Rebuild dwm with opacity changes
    ([ -f "$HOME"/Programs/dwm/config.h ] && rm -f "$HOME"/Programs/dwm/config.h  && echo 'Deleted old config.h, rebuilding dwm with new colorscheme' && cd "$HOME"/Programs/dwm/ && sudo make clean install) ||

    ( echo 'Rebuilding dwm with new color scheme' && cd "$HOME"/Programs/dwm/ && sudo make clean install)



#sed "s/^.*\[SchemeSelHighlight\] =.*/        \[SchemeSelHighlight\] = \{ ${1}, ${2} \},/" "$HOME"/Programs/dmenu/config.def.h
#echo $1
#echo $2


