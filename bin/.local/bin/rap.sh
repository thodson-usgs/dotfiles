#!/usr/bin/env bash
# Download RAP weather forecast
if [ "$#" -eq 0 ]; then
    HOUR=00
else
    HOUR=$1
fi

URL=http://weather.rap.ucar.edu/progs/prog$HOUR\hr.gif
wget -q -o /dev/null -O- $URL | feh - &
