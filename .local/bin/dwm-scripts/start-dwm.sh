#! /bin/sh

# Allows dwm to restart without logging out or closing applications
while true
do
    # Log stderror to a file
    dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done
