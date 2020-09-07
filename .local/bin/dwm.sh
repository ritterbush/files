#!/bin/sh

wallpaperFilepath=$(sed -n 5p ~/.local/bin/wallpaper-and-colors.sh | sed 's/filepath=//')

#Start compositor
picom &

#Restore wallpaper: uncomment whichever pkg used
#nitrogen --restore &
xwallpaper --zoom "$wallpaperFilepath" &

#Restore colorscheme
wal -R &

exec ~/.local/bin/start-dwm.sh 
