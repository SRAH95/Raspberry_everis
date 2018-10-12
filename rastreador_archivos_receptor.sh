#!/bin/bash
#Este programa se encargara de acceder al receptor con
#el objetivo de comprobar si hay algun archivo que no se descargo.
#Los Scripts check_empty_dir.sh y contains.sh deben estar en el mismo directorio que este Script.
#A este programa hay que entregarle 2 argumentos
#$1 El "Path" de donde estan los nombres de los archivos en la Raspberry pi.
#$2 El "Path" de donde estan los nombres de los archivos en el Receptor.

rastreador()
{
    . check_empty_dir.sh                        #Me devolvera una d=0 si el directorio esta vacio y d=1 si no.
    . contains.sh                               #Me devolvera una b=0 si el item se encuentra en la lista y b=1 si no.
    . upload_dropbox.sh                         #Subira los archivos a Dropbox.

    path_rasppi=$1                              #"Path" de donde estan los nombres de los archivos en la Raspberry pi.
    path_receptor=$2                            #"Path" de donde estan los nombres de los archivos en el Receptor.
    
    for i in $(ls $path_rasppi); do             #El archivo datos contiene la lista de los archivos contenidos                    
        echo $i >> datos                        #en Dropbox o en el receptor.
        check_empty "$path_rasppi$i"            #El archivo datos estara en el mismo directorio que este Script.                     
        if [ "d"=="0"]; then                    
            file=$(curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$i/ | awk '{print $9}' | tail -n 1)
            month=$(curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$i/ | awk '{print $6}' | tail -n 1)
            day=$(curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$i/ | awk '{print $7}' | tail -n 1)
            wget -m ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$i/$file -P /home/pi/Septentrio_data/
            #cd /home/pi/Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$j/
            #file=$(ls | tail -n 1)
            #find . ! -name "$file" -type f -exec rm -f {} +
            upload_dropbox "$path_rasppi$i/*" "Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$month_$day_$i/$month_$day_$file"
        fi
    done                                        

    for j in $path_receptor; do
        contains $j 
        if [ "b"=="1" ]; then
            file=$(curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$j/ | awk '{print $9}' | tail -n 1)
            month=$(curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$j/ | awk '{print $6}' | tail -n 1)
            day=$(curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$j/ | awk '{print $7}' | tail -n 1)
            wget -m ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$j/$file -P /home/pi/Septentrio_data/
            #cd /home/pi/Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$j/
            #file=$(ls | tail -n 1)
            #find . ! -name "$file" -type f -exec rm -f {} +
            upload_dropbox "$path_rasppi$j/*" "Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$month_$day_$j/$month_$day_$file"
        fi
    done

    rm datos
}

rastreador "/home/pi/Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/" "$(curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/ | awk '{print $9}')"