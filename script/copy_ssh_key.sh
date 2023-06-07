#!/bin/bash

# Advertimos al usuario de que se instalará el paquete sshpass en el sistema y que se requieren permisos de sudo

echo ""
echo "*******************************************************************************************************************"
echo ""
echo -e "\e[31mThe following script will install sshpass and you will need to have sudo permissions to run correctly.\e[0m"
echo ""
echo "*******************************************************************************************************************"
echo ""
read -p "Do you want to continue? (y/n): " yesornot

# Si el usuario ha aceptado las condiciones advertidas, se procede a la ejecución del script
if [[ "$yesornot" == "y" ]]; then

	# Se instala el paquete sshpass
	echo "Instalando paquete sshpass..."
	sudo yum install sshpass -y > /dev/null

	# Ruta del archivo CSV
	csv_file="hosts.csv"

	# Comprobamos si el archivo existe
	if [ ! -f "$csv_file" ]; then
		echo "El archivo $csv_file no existe."
		exit 1
	fi

	# Verificar si ya existe una clave SSH para el usuario actual
	if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
		# Genera una nueva clave SSH si no existe
		echo "Generando clave ssh..."
		ssh-keygen -t rsa -b 4096 -N "" -f "$HOME/.ssh/id_rsa" > /dev/null
        
		# Verificar si se ha generado con éxito
		if [ $? -eq 0 ]; then
			echo "Se ha generado una nueva clave SSH para el usuario $username."
		else
			echo "Error al generar una nueva clave SSH para el usuario $username."
			continue
		fi
	fi

	# Leemos el archivo CSV línea por línea
	while read -r line;
	do
		username=$(echo "$line" | awk -F, {'print $1'})
		ip=$(echo "$line" | awk -F, {'print $2'})
		password=$(echo "$line" | awk -F, {'print $3'})

		# Compartimos la clave SSH
		echo "Compartiendo clave ssh con $username@$ip..."
		sshpass -p "$password" ssh-copy-id -o StrictHostKeyChecking=no "$username@$ip" > /dev/null
    
		# Verificamos si la clave ha sido copiada con éxito
		if [ $? -eq 0 ]; then
			echo "Clave SSH compartida con éxito en el host $ip."
		else
			echo "Error al compartir la clave SSH en el host $ip."
		fi

	done < "$csv_file"

# Si el usuario decidió no continuar con el script tras la advertencia, se finaliza la ejecución
elif [[ "$yesornot" == "n" ]]; then
	echo "Ok! Bye!"
	exit 0
else
	echo "Incorrect option..."
	exit 1
fi
