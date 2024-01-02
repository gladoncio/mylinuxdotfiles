#!/bin/bash

# Mensaje de bienvenida
echo "¡Hola, bienvenido al script post grub!"

# Cargar configuración
source configuracion.sh


sudo pacman -S neofetch

sudo pacman -S lightdm lightdm-gtk-greeter

sudo sed -i 's/^#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf

sudo systemctl enable lightdm

sudo pacman -S qtile firefox rofi which nitrogen kitty

sudo pacman -S ttf-dejavu ttf-liberation noto-fonts

sudo pacman -S pulseaudio pavucontrol pamixer

sudo pacman -S arandr udiskie netowork-manager-applet

sudo pacman -S volumeicon cbatticon xorg-xinit thunar ranger glib2 gvfs lxappearance picom geeqie vlc 