#! /bin/sh
#Whitespace in filepaths will not work, because we need to wrap it in quotes

#Path to the image file after running script with a filepath argument; keep it on line 5
filepath=/home/paul/Pictures/Wallpapers/Pexels/pave-covered-on-red-leaf-between-trees-693521.jpg

#Check that required packages are installed
#type xwallpaper > /dev/null 2>&1 || type wal > /dev/null 2>&1 || (echo 'Install xwallpaper and pywal to use this command' && exit 1)
#type xwallpaper > /dev/null 2>&1 || (echo 'Install xwallpaper to use this command' && exit 1)
command -v wal > /dev/null 2>&1 || { echo "Install pywal to use this command.";  exit; }

#Check if there is an arg that is a filepath; if so replace filepath var above, set wallpaper, and set colors
[ -f "$1" ] &&
    #sed -i "5s|.*|filepath=$1|" ~/.local/bin/wallpaper-and-colors.sh && 
    #xwallpaper --zoom "$1" && 
    wal -i "$1"

#Check if there is an arg that is a directory; if so pick a random file, and do same as above with filepath
[ -d "$1" ] &&
    shuffle=$(find "$1" -type f -name "*.jpg" -o -name "*.png" -o -name "*.gif" | shuf -n 1) && 
    #sed -i "5s|.*|filepath=$shuffle|" ~/.local/bin/wallpaper-and-colors.sh &&
    #xwallpaper --zoom "$shuffle" &&
    wal -i "$shuffle"

#Set colors with previously set wallpaper if no argument is given 
[ $# -eq 0 ] &&
    #wal -i "$filepath"
    wal -R

#Rebuild dwm with new colorscheme
[ -f ~/Programs/dwm/config.def.h ] &&
    
    sed -i "s/static const char norm_fg\[\] = .*/$(sed -n 1p ~/.cache/wal/colors-wal-dwm.h)/" ~/Programs/dwm/config.def.h &&
    sed -i "s/static const char norm_bg\[\] = .*/$(sed -n 2p ~/.cache/wal/colors-wal-dwm.h)/" ~/Programs/dwm/config.def.h &&
    sed -i "s/static const char norm_border\[\] = .*/$(sed -n 3p ~/.cache/wal/colors-wal-dwm.h)/" ~/Programs/dwm/config.def.h &&
    sed -i "s/static const char sel_fg\[\] = .*/$(sed -n 5p ~/.cache/wal/colors-wal-dwm.h)/" ~/Programs/dwm/config.def.h &&
    sed -i "s/static const char sel_bg\[\] = .*/$(sed -n 6p ~/.cache/wal/colors-wal-dwm.h)/" ~/Programs/dwm/config.def.h &&
    sed -i "s/static const char sel_border\[\] = .*/$(sed -n 7p ~/.cache/wal/colors-wal-dwm.h)/" ~/Programs/dwm/config.def.h &&


        ([ -f ~/Programs/dwm/config.h ] && rm -f ~/Programs/dwm/config.h  && echo 'Deleted old config.h, rebuilding dwm with new colorscheme' && cd ~/Programs/dwm/ && sudo make clean install) ||

        ( echo 'Rebuilding dwm with new color scheme' && cd ~/Programs/dwm/ && sudo make clean install)



#Rebuild dmenu with new colorscheme
[ -f ~/Programs/dmenu/config.def.h ] &&
    sed -i "s/^.*\[SchemeNorm\].*/$(sed -n 3p ~/.cache/wal/colors-wal-dmenu.h)/" ~/Programs/dmenu/config.def.h &&
    sed -i "s/^.*\[SchemeSel\].*/$(sed -n 4p ~/.cache/wal/colors-wal-dmenu.h)/" ~/Programs/dmenu/config.def.h &&
    sed -i "s/^.*\[SchemeOut\].*/$(sed -n 5p ~/.cache/wal/colors-wal-dmenu.h)/" ~/Programs/dmenu/config.def.h &&
    colorNewHighlight=$(sed -n 7p ~/.cache/wal/colors) &&
    colorNewHighlight=$(echo "$colorNewHighlight" | sed "s/^/\"/") &&
    colorNewHighlight=$(echo "$colorNewHighlight" | sed "s/$/\"/") &&
    color2=$(grep "\[SchemeSel\] =" ~/Programs/dmenu/config.def.h) &&
    color2=$(echo "$color2" | sed "s/^.*, //") &&
    color2=${color2% \},} &&
    color3=$(grep "\[SchemeNorm\] =" ~/Programs/dmenu/config.def.h) &&
    color3=$(echo "$color3" | sed "s/^.*, //") &&
    color3=${color3% \},} &&
    sed -i "s/^.*\[SchemeSelHighlight\] =.*/        \[SchemeSelHighlight\] = \{ ${colorNewHighlight}, ${color2} \},/" ~/Programs/dmenu/config.def.h &&
    sed -i "s/^.*\[SchemeNormHighlight\] =.*/        \[SchemeNormHighlight\] = \{ ${colorNewHighlight}, ${color3} \},/" ~/Programs/dmenu/config.def.h &&


        ([ -f ~/Programs/dmenu/config.h ] && rm -f ~/Programs/dmenu/config.h  && echo 'Deleted old config.h, rebuilding dmenu with new colorscheme' && cd ~/Programs/dmenu/ && sudo make clean install) ||

        ( echo 'Rebuilding dmenu with new color scheme' && cd ~/Programs/dmenu/ && sudo make clean install)
