#!/bin/bash

contains() {
    if [[ "$a" =~ $(echo ^\($(paste -sd'|' /home/rodrigo/Script/datos)\)$)  ]]; then
        echo "hola"
    else 
        echo "adios"
    fi

}