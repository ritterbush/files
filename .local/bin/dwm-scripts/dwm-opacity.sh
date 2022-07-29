#! /bin/sh

#Seds new opacity value to dwm after converting it into its equivalent hex and then rebuilds dwm.
#Could also add a restart to dwm at the end, but I prefer the control of restarting dwm with the hotkeys
#I might do it anyway

#Check that argument is a number
if [ -z "${1##*[!0-9]*}" ]
then
    echo "Numbers 0-100 only."
    exit 1
fi

percent_of_255="$(($1 * 255 / 100))"
percent_of_255_hex=$(printf "%x\n" "$percent_of_255")

if [ ${#percent_of_255_hex} -eq 1 ]
    then 
        sed -i "s/static const unsigned int baralpha = .*/static const unsigned int baralpha = 0x0${percent_of_255_hex};/" ~/Programs/dwm/config.def.h
elif [ ${#percent_of_255_hex} -eq 2 ]
    then
        sed -i "s/static const unsigned int baralpha = .*/static const unsigned int baralpha = 0x${percent_of_255_hex};/" ~/Programs/dwm/config.def.h
fi

#Rebuild dwm with opacity changes
{ [ -f ~/Programs/dwm/config.h ] && rm -f ~/Programs/dwm/config.h  && echo "Deleted old config.h, rebuilding dwm with new opacity" && cd ~/Programs/dwm/ && sudo make clean install ; } ||

    { echo "Rebuilding dwm with new opacity" && cd ~/Programs/dwm/ && sudo make clean install ; }
