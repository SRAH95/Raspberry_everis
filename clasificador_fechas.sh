#!/bin/bash
#A esta función se le vamos a pasar cinco argumentos.
#$1=La fecha de referencia.
#$2=La hora de referencia.
#$3=El "Path" de donde se encuentra las fechas a comparar.
#$4=El "Path" de donde se encuentra las horas a comparar.
#$5=El "Path" de donde se encuentra los archivos a escoger.
# Recordar poner | tac al final para que los outputs vengan ya invertidos.

declare -i i
declare -i j

clasificador()
{
    j=1
    i=1
    arr_fechas=()                           #Lista de las fechas.                                                       
    arr_dir=()                              #Lista de todos los directorios.
    arr_dir_out=()                          #Lista salida con todos los directorios que queremos descargar.        

    fecha_ref=$1
    
    for f in $3; do                         #Paso las fechas a una lista con
        arr_fechas+=("$f")                  #las que poder trabajar con ellas.
    done 

    for d in $5; do                         #Paso los archivos a una lista con
        arr_dir+=("$d")                     #los que poder trabajar con ellos.
    done

    #i=$((${#arr_fechas[*]}-2))

    while (("${arr_fechas[$j]}" > "$fecha_ref")); do
        arr_dir_out+=(${arr_dir[$j]})
        j=$((j+1))
    done
}