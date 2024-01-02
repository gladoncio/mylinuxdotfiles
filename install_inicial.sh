#!/bin/bash

# Mensaje de bienvenida
echo "¡Hola, bienvenido al script de post-instalación de Arch Linux!"

# Cargar configuración
source configuracion.sh

# Configurar locales
echo "$LOCALE UTF-8" > /etc/locale.gen
locale-gen

export LANG=$LOCALE

pacman -Sy

echo "LANG=$LOCALE" > /etc/locale.conf

# Configurar la zona horaria
ln -sf "/usr/share/zoneinfo/$ZONA_HORARIA" /etc/localtime

hwclock --systohc


# Configurar teclado
echo "KEYMAP=$TECLADO" > /etc/vconsole.conf

# Configurar el nombre del sistema
echo "$NOMBRE_SISTEMA" > /etc/hostname

# Configurar el archivo hosts
echo "127.0.0.1    localhost" >> /etc/hosts
echo "::1          localhost" >> /etc/hosts
echo "127.0.1.1    $NOMBRE_SISTEMA.localdomain    $NOMBRE_SISTEMA" >> /etc/hosts


# Crear un usuario y establecer contraseña
useradd -m -g users -G wheel,storage,power -s /bin/bash $USUARIO

passwd $USUARIO

passwd root

# Descomentar la línea %wheel ALL=(ALL:ALL) ALL
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL$/%wheel ALL=(ALL:ALL) ALL/' $SUDOERS_FILE

# Agregar la línea $USUARIO ALL=(ALL:ALL) ALL
echo "$USUARIO ALL=(ALL:ALL) ALL" >> $SUDOERS_FILE

pacman -S dhcp dhcpcd networkmanager iwd

systemctl enable dhcpcd NetworkManager 

pacman -S reflector

reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist


pacman -S grub os-prober ntfs-3g

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

    grub-install "/dev/$disk_name"