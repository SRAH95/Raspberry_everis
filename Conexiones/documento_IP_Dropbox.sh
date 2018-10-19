#!/bin/bash

date=$(date)
wlan0_local=$(hostname -I | awk '{print $2}')
wlan0_publica=$(curl ifconfig.me)

echo Este documento fue generado el $date
echo -e "\n"
echo "Este documento contiene las direcciones IP, local y publica, de la raspberry pi"
echo correspondiente al roputer al que esta conectado.
echo -e "\n"
echo Este documento es meramente informativo para tener conocimiento de las direcciones
echo "IP local y publica en caso de que sea necesaria alguna de las dos."
echo -e "\n"
echo "La IP local correspondiente a la red Wlan0 es: $wlan0_local"
echo "La IP publica correspondiente a la red wlan0 es: $wlan0_publica"


