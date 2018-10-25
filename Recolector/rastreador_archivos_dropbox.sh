#!/bin/bash
#Este programa se encargara de acceder al receptor con
#el objetivo de comprobar si hay algun archivo que no se descargo.
#Los Scripts check_empty_dir.sh y contains.sh deben estar en el mismo directorio que este Script.
#A este programa hay que entregarle 2 argumentos
#$1 El "Path" de donde estan los nombres de los archivos en la Raspberry pi.
#$2 El "Path" de donde estan los nombres de los archivos en el Receptor.

rastreador_dropbox()
{
    . upload_dropbox.sh
    . contains.sh                               					#Me devolvera una b=0 si el item se encuentra en la lista y b=1 si no.

    path_rasppi=$1                              					#"Path" de donde estan los nombres de los archivos en la Raspberry pi.
    path_dropbox=$2                             					#"Path" de donde estan los nombres de los archivos en el Receptor.

    arr_dropbox_dir=()                          					#Lista que contendra los directorio en Dropbox que contiene los archivos.
    			                         					#Lista que contendra los archivos de los directorios.

    for i in $path_dropbox; do
        arr_dropbox_dir+=("$i")
    done
    
    for ((j=2; j<${#arr_dropbox_dir[@]}; j=$((j+3)))); do     				#El archivo datos contiene la lista de los archivos contenidos
        echo ${arr_dropbox_dir[$j]} >> /home/pi/Scripts/Recolector/data_names           #en Dropbox o en el receptor.
    done                                                				#El archivo datos estara en el mismo directorio que este Script.

    for z in $(ls $path_rasppi); do
        file=$(ls $path_rasppi$z/)
        contains "$file"
        if (("$b"=="1")); then
            upload_dropbox "$path_rasppi$z/*" "Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_GSA_RINEX_24H/"
        fi
    done

    rm /home/pi/Scripts/Recolector/data_names
}

#dropbox_files=$(/home/pi/Dropbox-Uploader/./dropbox_uploader.sh -q list Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/)
#rastreador_dropbox "/home/pi/Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/" "$dropbox_files"
