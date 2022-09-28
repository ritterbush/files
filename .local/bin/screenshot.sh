#!/bin/sh

# Add naming options later

name=$(date '+%B-%d-%l:%M:%S%p-%Y')

delay=3 # Default value if no args
[ -n "$1" ] && { case $1 in *[!0-9]*) { echo "$0 accepts only numerical arguments"; exit 1; } ;; esac; }
[ -n "$1" ] && delay=$1 # $1 exists and is a number

sleep ${delay}s

import -window root "$name".png
