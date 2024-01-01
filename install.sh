#!/bin/bash

# Mensaje de bienvenida
echo "¡Hola, bienvenido al instalador automático de Arch Linux!"

# Configurar el diseño de teclado
loadkeys es

# Configurar la configuración regional y de idioma
echo "es_ES.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
export LANG=es_ES.UTF-8

# Actualizar la base de datos de paquetes
pacman -Sy

# Limpiar la pantalla
clear

# Mostrar información sobre los discos disponibles con opciones numeradas
echo "Discos disponibles:"
lsblk -d -o NAME,SIZE,TYPE --noheadings | nl -w2 -s') '

# Solicitar al usuario que elija un disco por número
echo -n "Ingrese el número del disco en el que desea configurar las particiones: "
read choice

# Obtener el nombre del disco seleccionado
disk_name=$(lsblk -d -o NAME --noheadings | sed -n "${choice}p")

# Verificar si el disco ingresado es válido
if [ -n "$disk_name" ]; then
    # Ejecutar cfdisk para configurar particiones
    cfdisk "/dev/$disk_name"

    # Mostrar información sobre particiones del disco seleccionado después de cfdisk
    echo "Particiones actuales en /dev/$disk_name:"
    lsblk "/dev/$disk_name"

    # Solicitar al usuario que elija una partición para darle formato ext4
    echo -n "Ingrese el número de la partición a la que desea dar formato ext4: "
    read partition_choice

    # Obtener el nombre de la partición seleccionada
    partition_name="/dev/${disk_name}${partition_choice}"

    # Verificar si la partición ingresada es válida# Verificar si la partición ingresada es válida
    if [ -b "$partition_name" ]; then
        # Formatear la partición como ext4
        mkfs.ext4 "$partition_name"

        echo "¡La partición $partition_name ha sido formateada como ext4 con éxito!"

        # Montar la partición en /mnt
        mount "$partition_name" /mnt/

        # Verificar si la partición se montó correctamente
        if mountpoint -q /mnt; then
            echo "La partición $partition_name se ha montado en /mnt con éxito."
        else
            echo "¡Error al intentar montar la partición en /mnt! Abortando."
            exit 1
        fi
    else
        echo "¡La opción de partición ingresada no es válida! Abortando."
        exit 1
    fi
else
    echo "¡La opción de disco ingresada no es válida! Abortando."
    exit 1
fi


