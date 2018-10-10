#!/bin/bash

#$2=$(/home/pi/Script/Raspberry_everis/datos)

contains() {
    if [[ "$1" =~ $(echo ^\($(paste -sd'|' /home/pi/Script/Raspberry_everis/datos)\)$)  ]]; then
        b=0
    else
        b=1
    fi
}