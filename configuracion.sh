# configuracion.sh

# Variables para la instalación base
ZONA_HORARIA=$(curl -s https://ipapi.co/timezone)
LOCALE="es_CL.UTF-8"
TECLADO="latam"
NOMBRE_SISTEMA="archlinux"
USUARIO="gladoncio"

# Configurar sudoers
SUDOERS_FILE="/etc/sudoers"
