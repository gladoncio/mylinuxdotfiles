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

sudo pacman -S xkeyboard-config

setxkbmap -layout es -variant latam

#sudo systemctl restart display-manager.service

# Instala Xorg y utilidades básicas (si no están instaladas)
sudo pacman -Syu --noconfirm xorg-xinit mesa

# Utiliza lspci para obtener información sobre la tarjeta gráfica
gpu_info=$(lspci | grep VGA)
echo "Información de la tarjeta gráfica: $gpu_info"

# Determina el controlador de gráficos basándote en la información de lspci
if [[ $gpu_info == *"Intel"* ]]; then
    echo "Detectada tarjeta gráfica Intel. Instalando controlador para Intel."
    sudo pacman -S --noconfirm xf86-video-intel
elif [[ $gpu_info == *"NVIDIA"* ]]; then
    echo "Detectada tarjeta gráfica NVIDIA. Instalando controlador para NVIDIA."
    sudo pacman -S --noconfirm nvidia
elif [[ $gpu_info == *"AMD"* ]]; then
    echo "Detectada tarjeta gráfica AMD. Instalando controlador para AMD."
    sudo pacman -S --noconfirm xf86-video-amdgpu
elif [[ $gpu_info == *"QEMU"* || $gpu_info == *"VirtualBox"* || $gpu_info == *"VMware"* ]]; then
    echo "Detectada máquina virtual. Instalando controlador genérico."
    sudo pacman -S --noconfirm xf86-video-vesa
else
    echo "No se pudo determinar automáticamente el controlador de gráficos. Por favor, instálalo manualmente."
fi


# # Configura Xorg
# echo "Section \"Device\"
#     Identifier  \"Auto-detected Graphics\"
#     Driver      \"auto-detected\"
# EndSection" | sudo tee /etc/X11/xorg.conf.d/20-auto-detected.conf > /dev/null

# # Inicia Xorg automáticamente al iniciar sesión en la consola
# echo "exec startx" | sudo tee /root/.bash_profile > /dev/null

# echo "Configuración de controladores de gráficos y Xorg completada con éxito."