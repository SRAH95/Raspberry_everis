#!/bin/bash

#El Path que se da en la linea 7 debe ser el del fichero "datos"
#$2=$(/home/pi/Script/Raspberry_everis/datos)

contains() {
    if [[ "$1" =~ $(echo ^\($(paste -sd'|' /home/pi/Script/Raspberry_everis/datos)\)$)  ]]; then
        b=0
    else
        b=1
    fi
}