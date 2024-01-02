#!/bin/bash
# Mensaje de bienvenida
echo "¡Hola, bienvenido al script post grub!"

# Cargar configuración
source configuracion.sh


sudo pacman -S neofetch

sudo pacman -S lightdm lightdm-gtk-greeter

sudo sed -i 's/^#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf

sudo systemctl enable lightdm

sudo pacman -S qtile firefox rofi which nitrogen kitty arandr

sudo pacman -S ttf-dejavu ttf-liberation noto-fonts

sudo pacman -S pulseaudio pavucontrol pamixer

sudo pacman -S arandr udiskie netowork-manager-applet

sudo pacman -S volumeicon cbatticon xorg-xinit thunar ranger glib2 gvfs lxappearance picom geeqie vlc 

sudo pacman -S xkeyboard-config

sudo pacman -S htop lolcat unzip

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

# Obtener el nombre de usuario principal
USERNAME="$SUDO_USER"

# Si SUDO_USER está vacío, intentar obtener el nombre de usuario actual
if [ -z "$USERNAME" ]; then
    USERNAME=$(logname)
fi

# Ruta de destino
destino="/home/$USERNAME/.config/"

destino_usuario="/home/$USERNAME"


# Verificar si la carpeta qtile existe
if [ -d "qtile" ]; then
    # Copiar la carpeta y su contenido al destino
    sudo cp -r qtile "$destino"
    echo "Carpeta qtile copiada a $destino"
else
    echo "La carpeta qtile no existe en el directorio actual."
fi

if [ -d "picom" ]; then
    # Copiar la carpeta y su contenido al destino
    sudo cp -r picom "$destino"
    echo "Carpeta picom copiada a $destino"
else
    echo "La carpeta picom no existe en el directorio actual."
fi


if [ -d "kitty" ]; then
    # Copiar la carpeta y su contenido al destino
    sudo cp -r kitty "$destino"
    echo "Carpeta kitty copiada a $destino"
else
    echo "La carpeta kitty no existe en el directorio actual."
fi


if [ -d "rofi" ]; then
    # Copiar la carpeta y su contenido al destino
    sudo cp -r rofi "$destino"
    echo "Carpeta rofi copiada a $destino"
else
    echo "La carpeta rofi no existe en el directorio actual."
fi

if [ -d "wallpapers" ]; then
    # Copiar la carpeta y su contenido al destino
    sudo cp -r wallpapers "$destino_usuario"
    echo "Carpeta wallpapers copiada a $destino_usuario"
else
    echo "La carpeta wallpapers no existe en el directorio actual."
fi


# Ruta de la carpeta que contiene las imágenes
ruta_imagenes="$destino_usuario/wallpapers/"

# Obtener la lista de todas las pantallas
pantallas=$(xrandr --listmonitors | awk 'NR > 1 {print $4}')

# Iterar sobre cada pantalla y establecer el fondo de pantalla
for pantalla in $pantallas; do
    # Generar una ruta de imagen única para cada pantalla
    ruta_imagen="$ruta_imagenes$background.jpg"

    # Verificar si la imagen existe
    if [ -f "$ruta_imagen" ]; then
        # Establecer fondo de pantalla para la pantalla actual
        nitrogen --head="$pantalla" --set-scaled "$ruta_imagen" --save
    else
        echo "La imagen para la pantalla $pantalla no existe: $ruta_imagen"
    fi
done


# # Configura Xorg
# echo "Section \"Device\"
#     Identifier  \"Auto-detected Graphics\"
#     Driver      \"auto-detected\"
# EndSection" | sudo tee /etc/X11/xorg.conf.d/20-auto-detected.conf > /dev/null

# # Inicia Xorg automáticamente al iniciar sesión en la consola
# echo "exec startx" | sudo tee /root/.bash_profile > /dev/null

# echo "Configuración de controladores de gráficos y Xorg completada con éxito."