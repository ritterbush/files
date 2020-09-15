#! /bin/sh

#Options: -f [font name] -s [size number] -a [enables antialiasing] -h [enables auto hinting--makes font look better]

#Use fc-list on the command line to see available fonts; use the name on the right. If there are spaces, encapsulate it in quotes.

#Seds new font value to dwm after converting it into its equivalent hex and then rebuilds dwm.

#Check that argument is a number
#[[ $1 =~ ^-?[0-9]+$ ]] &&

size=':size=10'
antialias=''
autohint=''

while getopts ":f:s:ah" opt; do
  case ${opt} in
    f ) font=${OPTARG}
      ;;
    s ) size='size=':${OPTARG}
      ;;
    a ) antialias=':antialias=true'
      ;;
    h ) autohint=':autohint=true'
      ;;
  esac
done

echo $font
echo $size
echo $antialias
echo $autohint

font=${font}${size}${antialias}${autohint}

echo $font

sed -i "s/^static const char \*fonts\[\]          = { \".*/static const char *fonts[]          = { \"$font\" };/" ~/Programs/dwm/config.def.h
sed -i "s/^static const char dmenufont\[\]       = \".*/static const char dmenufont[]       = \"$font\";/" ~/Programs/dwm/config.def.h


#Rebuild dwm with font changes
    ([ -f "$HOME"/Programs/dwm/config.h ] && rm -f "$HOME"/Programs/dwm/config.h  && echo 'Deleted old config.h, rebuilding dwm with new fonts' && cd "$HOME"/Programs/dwm/ && sudo make clean install) ||

    ( echo 'Rebuilding dwm with new fonts' && cd "$HOME"/Programs/dwm/ && sudo make clean install)



