#! /bin/sh

# Add naming options later

name=$(date '+%B-%d-%l:%M:%S%p-%Y')

delay=0
[ $# -eq 0 ] && delay=3 # Default value if no args
[ -n "$1" ] && [ -z "${1##*[!0-9]*}" ] && delay=$1 # if $1 exists and is a number

sleep ${delay}s

import -window root "$name".png
