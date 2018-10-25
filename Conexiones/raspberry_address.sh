#!/bin/sh

sleep 30

cd /home/pi/Scripts/Conexiones/

./autoconnect_ngrok.sh ; ./IP_upload.sh
