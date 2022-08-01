#!/bin/sh

command -v wal > /dev/null 2>&1 || { echo "Install pywal to use this command.";  exit 1 ;}

# Use previously set wallpaper if no argument is given
[ $# -eq 0 ] &&
    wal -R

# Use file if arg is a filepath
[ -f "$1" ] &&
    wal -i "$1"

# Use a random picture from arg if arg is a directory
[ -d "$1" ] &&
    shuffle=$(find "$1" -type f -name "*.jpg" -o -name "*.png" -o -name "*.gif" | shuf -n 1) &&
    wal -i "$shuffle"

# Rebuild dwm with new colorscheme
[ -f $HOME/Programs/dwm/config.def.h ] &&
    { [ -f $HOME/Programs/dwm/config.h ] && rm -f $HOME/Programs/dwm/config.h  && echo 'Deleted old config.h, rebuilding dwm with new colorscheme' && cd $HOME/Programs/dwm/ && sudo make clean install ;} ||

        { echo 'Rebuilding dwm with new color scheme' && cd $HOME/Programs/dwm/ && sudo make clean install ;}

# Rebuild dmenu with new colorscheme
[ -f $HOME/Programs/dmenu/config.def.h ] &&
    sed -i "s/^.*\[SchemeNorm\].*/$(sed -n 3p $HOME/.cache/wal/colors-wal-dmenu.h)/" $HOME/Programs/dmenu/config.def.h &&
    sed -i "s/^.*\[SchemeSel\].*/$(sed -n 4p $HOME/.cache/wal/colors-wal-dmenu.h)/" $HOME/Programs/dmenu/config.def.h &&
    sed -i "s/^.*\[SchemeOut\].*/$(sed -n 5p $HOME/.cache/wal/colors-wal-dmenu.h)/" $HOME/Programs/dmenu/config.def.h &&
    colorNewHighlight=$(sed -n 7p $HOME/.cache/wal/colors) &&
    colorNewHighlight=$(echo "$colorNewHighlight" | sed "s/^/\"/") &&
    colorNewHighlight=$(echo "$colorNewHighlight" | sed "s/$/\"/") &&
    color2=$(grep "\[SchemeSel\] =" $HOME/Programs/dmenu/config.def.h) &&
    color2=$(echo "$color2" | sed "s/^.*, //") &&
    color2=${color2% \},} &&
    color3=$(grep "\[SchemeNorm\] =" $HOME/Programs/dmenu/config.def.h) &&
    color3=$(echo "$color3" | sed "s/^.*, //") &&
    color3=${color3% \},} &&
    sed -i "s/^.*\[SchemeSelHighlight\] =.*/        \[SchemeSelHighlight\] = \{ ${colorNewHighlight}, ${color2} \},/" $HOME/Programs/dmenu/config.def.h &&
    sed -i "s/^.*\[SchemeNormHighlight\] =.*/        \[SchemeNormHighlight\] = \{ ${colorNewHighlight}, ${color3} \},/" $HOME/Programs/dmenu/config.def.h &&

    { [ -f $HOME/Programs/dmenu/config.h ] && rm -f $HOME/Programs/dmenu/config.h  && echo 'Deleted old config.h, rebuilding dmenu with new colorscheme' && cd $HOME/Programs/dmenu/ && sudo make clean install ;} ||

        { echo 'Rebuilding dmenu with new color scheme' && cd $HOME/Programs/dmenu/ && sudo make clean install ;}
