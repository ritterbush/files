#!/bin/sh

wallpaperFilepath=$(sed -n 5p ~/.local/bin/wallpaper-and-colors.sh | sed 's/filepath=//')

# Start compositor
picom &

# Restore wallpaper: uncomment whichever pkg used
#nitrogen --restore &
xwallpaper --zoom "$wallpaperFilepath" &

# Restore colorscheme
wal -R &

# Run dwm status bar
~/.local/bin/dwm-scripts/update-setxroot.sh &

exec ~/.local/bin/dwm-scripts/start-dwm.sh 
