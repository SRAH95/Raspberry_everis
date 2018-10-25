#!/bin/sh
#script me da la IP
#sudo update-rc.d autoconnectnet defaults

dia=$(date | awk '{print $1}')
mes=$(date | awk '{print $2}')
fecha=$(date |awk '{print $3}')
hora=$(date | awk '{print $4}')
cd /home/pi/Script/Conexiones/
./documento_IP_Dropbox.sh > raspberry_IPs_"$dia"_"$mes"_"$fecha"_"$hora".txt
sudo mv raspberry_IPs_"$dia"_"$mes"_"$fecha"_"$hora".txt /home/pi/Dropbox-Uploader/archivos_reinicio/
cd /home/pi/Dropbox-Uploader/
./dropbox_uploader.sh upload archivos_reinicio/* Raspberry_address/IP_address/
cd archivos_reinicio/ && rm raspberry_IPs_"$dia"_"$mes"_"$fecha"_"$hora".txt

