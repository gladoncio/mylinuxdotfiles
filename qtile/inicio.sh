#!/bin/sh


#CONFIGURACION TECLADO
setxkbmap latam &

xrandr --output Virtual-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal &

picom -b &

udiskie - t & 

nm-applet &

volumeicon &

cbatticon -u 5 &

nm-applet &

nitrogen --restore & 

#barrier --no-tray --enable-crypto --name gladoncio --ip-addr 192.168.18.106 &