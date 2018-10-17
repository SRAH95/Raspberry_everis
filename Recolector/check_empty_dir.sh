#!/bin/bash
#$1=/path/to/dir

declare -i d

check_empty()
{
    if [ -z "$(ls $1)" ]; then
        d=0     #Empty
#	echo "empty"
    else
        d=1     #Not Empty
#	echo "not empty"
    fi
}

check_empty "/home/pi/Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/18282/"
