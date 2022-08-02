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
# Unfortunately, a highlight patch means we have to manually edit dmenu's wal cache file
sed -i '4 a\
	[SchemeSelHighlight] = { leftHlColor, color1 },' \
$HOME/.cache/wal/colors-wal-dmenu.h
sed -i '5 a\
	[SchemeNormHighlight] = { leftHlColor, color2 },' \
$HOME/.cache/wal/colors-wal-dmenu.h
sed -i '7 a\
	[SchemeNormHighlight] = { leftHlColor, color3 },' \
$HOME/.cache/wal/colors-wal-dmenu.h
leftHlColor=\"$(sed -n 7p $HOME/.cache/wal/colors)\"
color1=\"$(sed -n 10p $HOME/.cache/wal/colors)\"
color2=\"$(sed -n 1p $HOME/.cache/wal/colors)\"
color3=\"$(sed -n 3p $HOME/.cache/wal/colors)\"
sed -i "s/leftHlColor/$leftHlColor/g" $HOME/.cache/wal/colors-wal-dmenu.h
sed -i "s/color1/$color1/" $HOME/.cache/wal/colors-wal-dmenu.h
sed -i "s/color2/$color2/" $HOME/.cache/wal/colors-wal-dmenu.h
sed -i "s/color3/$color3/" $HOME/.cache/wal/colors-wal-dmenu.h

[ -f $HOME/Programs/dmenu/config.def.h ] &&

    { [ -f $HOME/Programs/dmenu/config.h ] && rm -f $HOME/Programs/dmenu/config.h  && echo 'Deleted old config.h, rebuilding dmenu with new colorscheme' && cd $HOME/Programs/dmenu/ && sudo make clean install ;} ||

        { echo 'Rebuilding dmenu with new color scheme' && cd $HOME/Programs/dmenu/ && sudo make clean install ;}
