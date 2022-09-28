#!/bin/sh

# Converts opacity value to hex equivalent and rebuilds dwm with it.
# Could also add a restart to dwm at the end, but I prefer the control of restarting dwm with the hotkeys.

#Check that argument is a number
case $1 in
    ''|*[!0-9]*) # Also guards against no arguments given; error given if handled below
        { echo "$0 accepts numbers 0-100 only."; exit 1; }
        ;;
esac

percent_of_255="$(($1 * 255 / 100))"
percent_of_255_hex=$(printf "%x\n" "$percent_of_255")

[ ${#percent_of_255_hex} -eq 1 ] &&
    sed -i "s/static const unsigned int baralpha = .*/static const unsigned int baralpha = 0x0${percent_of_255_hex};/" "$HOME"/Programs/dwm/config.def.h

[ ${#percent_of_255_hex} -eq 2 ] &&
    sed -i "s/static const unsigned int baralpha = .*/static const unsigned int baralpha = 0x${percent_of_255_hex};/" "$HOME"/Programs/dwm/config.def.h

[ ${#percent_of_255_hex} -gt 2 ] && { echo "Numbers 0-100 only."; exit 1; } # If $1 > 100, hex will have more than 2 digits

#Rebuild dwm with opacity changes
{ [ -f "$HOME"/Programs/dwm/config.h ] && rm -f "$HOME"/Programs/dwm/config.h  && echo "Deleted old config.h, rebuilding dwm with new opacity" && cd "$HOME"/Programs/dwm/ && sudo make clean install; } ||

    { echo "Rebuilding dwm with new opacity" && cd "$HOME"/Programs/dwm/ && sudo make clean install; }
