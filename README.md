# mylinuxdotfiles

![Preview](https://github.com/gladoncio/mylinuxdotfiles/preview.png)


Breve descripción de tu proyecto.

## Configuración

Todas las configuraciones del usuario se realizan en el archivo `configuracion.sh`. Asegúrate de revisar y ajustar este archivo según tus necesidades antes de utilizar los scripts.

## Requerimientos

- **Requisitos Iniciales:** Ninguno

## Inicio Rápido

1. Si estás utilizando un sistema Linux que no tiene configuraciones específicas, ejecuta el siguiente comando para instalar el sistema base:

```bash
./install_base.sh
```

2. Después de instalar el sistema base, inicia sesión y ejecuta el siguiente comando para realizar la instalación inicial:


```bash
./install_inicial.sh
```
 
3. Ya tienes un sistema definido y deseas instalar tus configuraciones personalizadas, ejecuta:
Asegúrate de reiniciar el sistema después de ejecutar este script.

```bash
./install_dotfiles.sh
```

4. Este script también utilizará Nitrogen para cambiar el fondo de pantalla.
Si prefieres utilizar el fondo de pantalla del repositorio, ejecuta:
```bash
./install_reboot.sh
```




Contribuciones
Si encuentras algún problema o tienes alguna mejora, no dudes en crear un problema o enviar una solicitud de extracción.