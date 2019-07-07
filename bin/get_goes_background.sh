#!/usr/bin/env bash

WALL_PATH=$HOME/Pictures/wallpaper
BASE_URL=https://cdn.star.nesdis.noaa.gov
MID_URL=ABI/CONUS/GEOCOLOR
FILE=-ABI-CONUS-GEOCOLOR-5000x3000.jpg
SAT=GOES16
TIMESTAMP=`date +%Y%j%H%M --utc`
ULTIMATE=$(( (($TIMESTAMP/5)*5+1) ))
PENULTIMATE=$(($ULTIMATE - 5))
OUT_FILE=$WALL_PATH/$SAT\_GEOCOLOR.jpg

URL1=$BASE_URL/$SAT/$MID_URL/$ULTIMATE\_$SAT$FILE
URL2=$BASE_URL/$SAT/$MID_URL/$PENULTIMATE\_$SAT$FILE

# try/catch 
{
    wget $URL1 -O $OUT_FILE
} || {
    wget $URL2 -O $OUT_FILE
} || {
    sleep 0
} 

#feh --bg-fill $OUT_FILE
