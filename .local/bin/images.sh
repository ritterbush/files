#! /bin/sh

#Uses sxiv to view an image directory;
#Select image(s) with m, and from selected, one is chosen at random to be the new wallpaper

[ -d "$1" ] && img=$(find "$1" -type f -name "*.jpg" -o -name "*.png" -o -name "*.gif" | shuf | sxiv -tio | shuf -n 1) && ~/.local/bin/wallpaper-and-colors.sh "$img"
