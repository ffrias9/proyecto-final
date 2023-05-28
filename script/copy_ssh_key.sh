#!/bin/bash

# Ruta del archivo CSV
csv_file="hosts.csv"

# Comprobar si el archivo existe
if [ ! -f "$csv_file" ]; then
    echo "El archivo $csv_file no existe."
    exit 1
fi

# Leer el archivo CSV línea por línea
while IFS=',' read -r username ip password; do
    # Verificar si ya existe una clave SSH para el usuario actual
    if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
        # Genera una nueva clave SSH si no existe
        ssh-keygen -t rsa -b 4096 -N "" -f "$HOME/.ssh/id_rsa"
        
        # Verificar si se ha generado con éxito
        if [ $? -eq 0 ]; then
            echo "Se ha generado una nueva clave SSH para el usuario $username."
        else
            echo "Error al generar una nueva clave SSH para el usuario $username."
            continue
        fi
    fi
    
    # Compartir la clave SSH
    sshpass -p "$password" ssh-copy-id -o StrictHostKeyChecking=no "$username@$ip"
    
    # Verificar si la clave ha sido copiada con éxito
    if [ $? -eq 0 ]; then
        echo "Clave SSH compartida con éxito en el host $ip."
    else
        echo "Error al compartir la clave SSH en el host $ip."
    fi
done < "$csv_file"

