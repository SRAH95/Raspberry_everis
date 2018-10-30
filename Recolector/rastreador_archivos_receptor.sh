#!/bin/bash
#Este programa se encargara de acceder al receptor con
#el objetivo de comprobar si hay algun archivo que no se descargo.
#Los Scripts check_empty_dir.sh y contains.sh deben estar en el mismo directorio que este Script.
#A este programa hay que entregarle 2 argumentos
#$1 El "Path" de donde estan los nombres de los archivos en la Raspberry pi.
#$2 El "Path" de donde estan los nombres de los archivos en el Receptor.

rastreador_receptor()
{
    . check_empty_dir.sh                       					 #Me devolvera una d=0 si el directorio esta vacio y d=1 si no.
    . contains.sh                              					 #Me devolvera una b=0 si el item se encuentra en la lista y b=1 si no.
                                            					 #Subira los archivos a Dropbox.

    path_rasppi=$1                             					 #"Path" de donde estan los nombres de los archivos en la Raspberry pi.
    path_receptor=$2                           					 #"Path" de donde estan los nombres de los archivos en el Receptor.

    for i in $(ls $path_rasppi); do            					 #El archivo datos contiene la lista de los archivos contenidos
        echo $i >> /home/pi/Scripts/Recolector/data_names                   	 #en Dropbox o en el receptor.
        check_empty "$path_rasppi$i"           					 #El archivo datos estara en el mismo directorio que este Script.
	if (("$d"=="0")); then
	    name=$(curl ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_GSA_RINEX_24H/$i/ | awk '{print $6 $7 $9}' | head -n 1)
            file=$(curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_GSA_RINEX_24H/$i/ | awk '{print $9}' | head -n 1)
            wget -m ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_GSA_RINEX_24H/$i/$file -P /home/pi/Septentrio_data/
            mv $path_rasppi$i/* $path_rasppi$i/$name
	    xz -9 $path_rasppi$i/$name
        fi
    done

    for j in $path_receptor; do
        contains $j
        if (("$b"=="1")); then
	    name=$(curl ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_GSA_RINEX_24H/$j/ | awk '{print $6 $7 $9}' | head -n 1)
            file=$(curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_GSA_RINEX_24H/$j/ | awk '{print $9}' | head -n 1)
            wget -m ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_GSA_RINEX_24H/$j/$file -P /home/pi/Septentrio_data/
	    mv $path_rasppi$j/* $path_rasppi$j/$name
	    xz -9 $path_rasppi$j/$name
        fi
    done

    rm /home/pi/Scripts/Recolector/data_names
}

#rastreador_receptor "/home/pi/Septentrio_data/192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/" "$(curl -s ftp://everis:IFEGSA@192.168.3.1/DSK1/SSN/LOG1_everis_prueba_RINEX_24H/ | awk '{print $9}')"
