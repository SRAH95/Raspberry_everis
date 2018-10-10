#!/bin/bash
#Este programa se encargara de acceder al receptor con
#el objetivo de comprobar si hay algun archivo que no se descargo.
#Los Scripts check_empty_dir.sh y contains.sh deben estar en el mismo directorio que este Script.
#A este programa hay que entregarle 2 argumentos
#$1 El "Path" de donde estan los nombres de los archivos en la Raspberry pi.
#$2 El "Path" de donde estan los nombres de los archivos en el Receptor.

rastreador()
{
    . contains.sh                               #Me devolvera una b=0 si el item se encuentra en la lista y b=1 si no.

    path_rasppi=$1                              #"Path" de donde estan los nombres de los archivos en la Raspberry pi.
    path_dropbox=$2                             #"Path" de donde estan los nombres de los archivos en el Receptor.
                                                
    arr_dropbox_dir=()                          #Lista que contendra los directorio en Dropbox que contiene los archivos.
    arr_dropbox_fich=()                         #Lista que contendra los archivos de los directorios.

    for i in $path_dropbox; do
        arr_dropbox_dir+=("$i")
    done

    for ((j=1; j<${#arr_dropbox_dir[@]}; j+=2)); do
        for z in $path_dropbox/$j; do                   #El archivo datos contiene la lista de los archivos contenidos
            echo $z >> datos                            #en Dropbox o en el receptor.
        done                                            #El archivo datos estara en el mismo directorio que este Script.
    done

    for k in $path_rasppi; do
        contains $k 
        if [ "b"=="1" ]; then
            #comando de subida.
    done
}