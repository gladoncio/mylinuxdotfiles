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
    # Mostrar información sobre particiones del disco seleccionado
    echo "Particiones actuales en /dev/$disk_name:"
    lsblk "/dev/$disk_name"

    # Configurar particiones usando cfdisk en el disco seleccionado
    cfdisk "/dev/$disk_name"
else
    echo "¡La opción ingresada no es válida! Abortando."
    exit 1
fi
