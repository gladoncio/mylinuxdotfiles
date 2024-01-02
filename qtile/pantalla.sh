#!/bin/bash

# Script para configurar automáticamente la disposición de la pantalla en Qtile

# Obtener el número de pantallas conectadas
num_screens=$(xrandr --query | grep " connected" | wc -l)


if [ "$num_screens" -eq 1 ]; then
    # Solo una pantalla, establecer la disposición extendida
    xrandr --auto
    nitrogen --restore
else
    # Más de una pantalla, establecer la disposición extendida
    xrandr --auto --output eDP-1 --primary --output HDMI-1-0 --auto --right-of eDP-1
    nitrogen --restore
fi


