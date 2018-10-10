#!/bin/bash
#$1=/path/to/dir

declare -i d

check_empty()
{
if [ -z "$(ls -A $1)" ]; then
    d=0     #Empty
else
    d=1     #Not Empty    
fi
}
