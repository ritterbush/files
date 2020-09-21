#! /bin/sh

# Add delay and naming options later

name=$(date '+%B-%d-%l:%M:%S%p-%Y')

sleep 3

import -window root "$name".png

