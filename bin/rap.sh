HOUR=$1
HOUR=00
URL=http://weather.rap.ucar.edu/progs/prog$HOUR\hr.gif

wget -q -o /dev/null -O- $URL | feh - &
