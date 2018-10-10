#!/bin/bash
#$1=/path/to/dir

declare -i d

check_empty()
{
if [ -z "$(ls -A $1)" ]; then
    #d=0     #Empty
    echo "empty"
else
    #d=1     #Not Empty
    echo "Not empty"
fi
}

check_empty "/home/pi/script"