#!/bin/bash
#Este programa se encargara de acceder al receptor con
#el objetivo de comprobar si hay algun archivo que no se descargo.
#Los Scripts check_empty_dir.sh y contains.sh deben estar en el mismo directorio que este Script.
#A este programa hay que entregarle 2 argumentos
#$1 El "Path" de donde estan los nombres de los archivos en la Raspberry pi.
#$2 El "Path" de donde estan los nombres de los archivos en el Receptor.

declare -i i

rastreador()
{
    . check_empty_dir.sh                        #Me devolvera una d=0 si el directorio esta vacio y d=1 si no.
    . contains.sh                               #Me devolvera una b=0 si el item se encuentra en la lista y b=1 si no.
    . upload_dropbox.sh                               
                                                
    i=0

    path_rasppi=$1                              #"Path" de donde estan los nombres de los archivos en la Raspberry pi.
    path_receptor=$2                            #"Path" de donde estan los nombres de los archivos en el Receptor.
    
    for j in ${path_receptor[*]}; do            #El archivo datos contiene la lista de los archivos contenidos            
        $j >> datos                             #en Dropbox o en el receptor.
    done                                        #El archivo datos estara en el mismo directorio que este Script.

    for j in $(ls $path_rasppi); do
        contains $j 
        check_empty "$path_rasppi$j"
        if [ "b"=="1" ]; then
            wget -m ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$j -P /home/pi/Septentrio_data/
            cd /home/pi/Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$j/
            file=$(ls | tail -n 1)
            find . ! -name "$file" -type f -exec rm -f {} +
            upload_dropbox "$path_rasppi$j/*" "Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$j/"
        elif [ "d"=="0"]; then
            wget -m ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$j -P /home/pi/Septentrio_data/
            cd /home/pi/Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$j/
            file=$(ls | tail -n 1)
            find . ! -name "$file" -type f -exec rm -f {} +
            upload_dropbox "$path_rasppi$j/*" "Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/$j/"
        fi
    done

    rm datos
}

rastreador "/home/pi/Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/" "curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/ | awk '{print $9}'"