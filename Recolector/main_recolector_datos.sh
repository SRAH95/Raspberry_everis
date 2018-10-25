#! /bin/bash

cd /home/pi/Scripts/Recolector/

. rastreador_archivos_receptor.sh
. rastreador_archivos_dropbox.sh

dropbox_files=$(/home/pi/Dropbox-Uploader/./dropbox_uploader.sh -q list Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_GSA_RINEX_24H/)
raspberry_files=/home/pi/Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_GSA_RINEX_24H/
receiver_files=$(curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_GSA_RINEX_24H/ | awk '{print $9}' | head -n -2)

rastreador_receptor "$raspberry_files" "$receiver_files" ; rastreador_dropbox "$raspberry_files" "$dropbox_files"
