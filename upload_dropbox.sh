#!/bin/bash
#Este script contiene un funcion que se encargará de subir los archivos que se le indequen a la cuenta de dropbox.
#Ha esta funcion hay que entregarle dos argumentos.
#$1 El "Path" donde se encuentra el archivo que queremos subir.
#$2 El "Path" donde se quiere que se suban los documentos.

upload_dropbox()
{
    mv $1 /home/pi/Dropbox-Uploader/script_upload_dropbox/ && cd /home/pi/Dropbox-Uploader
    ./dropbox_uploader.sh -q upload script_upload_dropbox/* $2
    cd script_upload_dropbox/ && rm *
}