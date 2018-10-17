#!/bin/bash

sleep 7

cd /home/pi/

dia=$(date | awk '{print $1}')
mes=$(date | awk '{print $2}')
fecha=$(date |awk '{print $3}')
hora=$(date | awk '{print $4}')

curl http://127.0.0.1:4040/api/tunnels > raspberry_ngrok_"$dia"_"$mes"_"$fecha"_"$hora".txt
sudo mv raspberry_ngrok_"$dia"_"$mes"_"$fecha"_"$hora".txt /home/pi/Dropbox-Uploader/archivos_reinicio/
cd /home/pi/Dropbox-Uploader
./dropbox_uploader.sh upload archivos_reinicio/* /Raspberry_address/Ngrok_address/
cd archivos_reinicio/ && rm raspberry_ngrok_"$dia"_"$mes"_"$fecha"_"$hora".txt

