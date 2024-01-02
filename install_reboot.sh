#!/bin/bash


# Obtener el nombre de usuario principal
USERNAME="$SUDO_USER"

# Si SUDO_USER está vacío, intentar obtener el nombre de usuario actual
if [ -z "$USERNAME" ]; then
    USERNAME=$(logname)
fi

# Ruta de destino
destino="/home/$USERNAME/.config/"

destino_usuario="/home/$USERNAME"

# Ruta de la carpeta que contiene las imágenes
ruta_imagenes="$destino_usuario/wallpapers/"

nitrogen "$ruta_imagenes"