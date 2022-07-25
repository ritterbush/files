#!/bin/sh

show_usage(){
    printf "Usage:\n\n  %s [options [parameters]]\n" "$0"
    printf "\n"
    printf "Easily gives dwm and dmenu a new font.\n"
    printf "\n"
    printf "Use \"fc-list\" on the command line to see available fonts; use the name
on the right side. If there are spaces, encapsulate it in quotes.\n"
    printf "\n"
    printf "Options [parameters]:\n"
    printf "\n"
    printf "  -f [font]   Specify font name.\n"
    printf "  -s [size]   Specify font size.\n"
    printf "  -aa         Use antialiasing.\n"
    printf "  -ah         Use autohinting. Makes font look better. \n"
    printf "  --default   Use the best: Linux Libertine:style=Bold Italic
                              with -aa and -ah.\n"
    printf "  -h|--help   Print this help.\n"
exit
}

font="Linux Libertine:style=Bold Italic"
size=":size=10"
antialias=""
autohint=""

[ $# -eq 0 ] && show_usage

while [ -n "$1" ]; do
    case "$1" in
        -f)
            if [ -n "$2" ]
            then
                font="$2"
                shift 2
            else
                echo "-f flag requires a font. Use -h to see cmd to get fonts."
                exit
            fi
            ;;
        -s)
            if [ -n "$2" ]
            then
                [ -z "${2##*[!0-9]*}" ] && { echo "Size requires a number."; exit; } # Check $2 is a number
                size=":size=$2"
                shift 2
            else
                echo "-s flag requires a font size."
                exit
            fi
            ;;
        -aa)
            antialias=":antialias=true"
            shift
            ;;
        -ah)
            autohint=":autohint=true"
            shift
            ;;
        --help|-h)
            show_usage
            ;;
        *)
            echo "Unknown option $1"
            show_usage
            ;;
    esac
done

font="${font}${size}${antialias}${autohint}"

# Put new font values into dwm (applies to dmenu too)
sed -i "s/^static const char \*fonts\[\]          = { \".*/static const char *fonts[]          = { \"$font\" };/" ~/Programs/dwm/config.def.h
sed -i "s/^static const char dmenufont\[\]       = \".*/static const char dmenufont[]       = \"$font\";/" ~/Programs/dwm/config.def.h

# Rebuild dwm with font changes (applies to dmenu too)
([ -f ~/Programs/dwm/config.h ] && rm -f ~/Programs/dwm/config.h  && echo "Deleted old config.h, rebuilding dwm with font value: $font" && cd ~/Programs/dwm/ && sudo make clean install) ||

    ( echo "Rebuilding dwm with font value: $font" && cd ~/Programs/dwm/ && sudo make clean install)
