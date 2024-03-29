#!/bin/bash
# Mensaje de bienvenida
echo "¡Hola, bienvenido al script post grub!"

# Cargar configuración
source configuracion.sh


sudo pacman -S lightdm lightdm-gtk-greeter

sudo sed -i 's/^#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf

sudo systemctl enable lightdm

sudo pacman -S qtile firefox rofi which nitrogen kitty arandr

sudo pacman -S ttf-dejavu ttf-liberation noto-fonts

sudo pacman -S pulseaudio pavucontrol pamixer

sudo pacman -S arandr udiskie

sudo pacman -S netowork-manager-applet

sudo pacman -S volumeicon cbatticon xorg-xinit thunar ranger glib2 gvfs lxappearance picom geeqie vlc 

sudo pacman -S xkeyboard-config

sudo pacman -S htop lolcat unzip

sudo pacman -S python-psutil

git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si

cd ..

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
destino="/home/$USERNAME/.config"

destino_usuario="/home/$USERNAME"


# Verificar si la carpeta qtile existe
if [ -d "qtile" ]; then
    # Copiar la carpeta y su contenido al destino
    sudo cp -r qtile "$destino"
    echo "Carpeta qtile copiada a $destino"
else
    echo "La carpeta qtile no existe en el directorio actual."
fi



# Verificar si la carpeta qtile existe
if [ -d "qtile" ]; then
    # Copiar la carpeta y su contenido al destino
    sudo cp -r qtile "$destino"
    echo "Carpeta qtile copiada a $destino"
else
    echo "La carpeta qtile no existe en el directorio actual."
fi


# if [ -d "picom" ]; then
#     # Copiar la carpeta y su contenido al destino
#     sudo cp -r picom "$destino"
#     echo "Carpeta picom copiada a $destino"
# else
#     echo "La carpeta picom no existe en el directorio actual."
# fi


if [ -d "kitty" ]; then
    # Copiar la carpeta y su contenido al destino
    sudo cp -r kitty "$destino/"
    echo "Carpeta kitty copiada a $destino/"
else
    echo "La carpeta kitty no existe en el directorio actual."
fi


if [ -d "rofi" ]; then
    # Copiar la carpeta y su contenido al destino
    sudo cp -r rofi "$destino"
    echo "Carpeta rofi copiada a $destino/"
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

if [ -d "neofetch" ]; then
    # Copiar la carpeta y su contenido al destino
    sudo cp -r neofetch "$destino"
    echo "Carpeta neofetch copiada a $destino"
else
    echo "La carpeta neofetch no existe en el directorio actual."
fi


# Activar el repositorio community
if ! grep -q '^\[community\]' "$pacman_conf"; then
    echo "[community]" | sudo tee -a "$pacman_conf" > /dev/null
fi
echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a "$pacman_conf" > /dev/null

# Activar el repositorio multilib
if ! grep -q '^\[multilib\]' "$pacman_conf"; then
    echo "[multilib]" | sudo tee -a "$pacman_conf" > /dev/null
fi
echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a "$pacman_conf" > /dev/null


# Actualizar la base de datos de paquetes
sudo pacman -Sy

sudo pacman -S zsh

yay -S nerd-fonts-complete-mono-glyphs

yay -S ttf-meslo-nerd

sudo pacman -S wget lsd feh


archivo_inicio="$destino/qtile/inicio.sh"

ruta_imagen_fondo="$destino_usuario/wallpapers/background.jpg"


wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh


chsh -s /bin/zsh $USERNAME


if [ -f ".zshrc" ]; then
    # Copiar el archivo al destino
    cp .zshrc "$destino_usuario"
    echo "Config zsh copiada a $destino_usuario"
else
    echo "La config zsh no existe en el directorio actual."
fi



sudo bash -c "cat <<EOL >> $archivo_inicio

# Verificar si la imagen de fondo existe
if [ -f "$ruta_imagen_fondo" ]; then
    # Establecer la imagen de fondo con feh
    feh --bg-fill "$ruta_imagen_fondo"
    echo \"Imagen de fondo establecida correctamente.\"
else
    echo \"La imagen de fondo no existe en la ruta especificada.\"
fi
EOL"

echo "Líneas de fondo de pantalla agregadas al archivo inicio.sh"


# # Configura Xorg
# echo "Section \"Device\"
#     Identifier  \"Auto-detected Graphics\"
#     Driver      \"auto-detected\"
# EndSection" | sudo tee /etc/X11/xorg.conf.d/20-auto-detected.conf > /dev/null

# # Inicia Xorg automáticamente al iniciar sesión en la consola
# echo "exec startx" | sudo tee /root/.bash_profile > /dev/null

# echo "Configuración de controladores de gráficos y Xorg completada con éxito."