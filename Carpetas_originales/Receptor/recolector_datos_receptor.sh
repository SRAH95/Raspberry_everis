#!/bin/bash

#m_data=$(curl ftp://192.168.3.1/DSK1/SSN/LOG1_everis_prueba_SBF/ --user everis:IFEGSA | awk '{print $6}')
#d_data=$(curl ftp://192.168.3.1/DSK1/SSN/LOG1_everis_prueba_SBF/ --user everis:IFEGSA | awk '{print $7}')
#h_data=$(curl ftp://192.168.3.1/DSK1/SSN/LOG1_everis_prueba_SBF/ --user everis:IFEGSA | awk '{print $8}')
#m_rasppi=$(date | awk '{print $2}')
#d_rasppi=$(date | awk '{print $3}')
#h_rasppi=$(date | awk '{print $4}')

. clasificador_fechas.sh
arr_direct=$(curl ftp://192.168.3.1/DSK1/SSN/LOG1_everis_prueba_SBF/ --user everis:IFEGSA | awk '{print $9}')
arr_day=$(curl ftp://192.168.3.1/DSK1/SSN/LOG1_everis_prueba_SBF/ --user everis:IFEGSA | awk '{print $7}')

dias "$arr_day" "$arr_direct"

cd /home/pi/Dropbox-Uploader/Septentrio_data/

for j in ${dir[*]}; do
	wget -m ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_SBF/${arr_dir[$j]}
done
