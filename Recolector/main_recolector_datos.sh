#! /bin/bash

cd /home/pi/Scripts/Recolector/

. rastreador_archivos_receptor.sh
. rastreador_archivos_dropbox.sh
#/bin/bash /home/pi/Scripts/Recolector/rastreador_archivos_receptor.sh
#/bin/bash /home/pi/Scripts/Recolector/rastreador_archivos_dropbox.sh

dropbox_files=$(/home/pi/Dropbox-Uploader/./dropbox_uploader.sh -q list Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/)

rastreador_receptor "/home/pi/Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/" "$(curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/ | awk '{print $9}')" && rastreador_dropbox "/home/pi/Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/" "$dropbox_files"
