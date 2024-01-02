#!/bin/sh


#CONFIGURACION TECLADO
setxkbmap latam &

picom -b &

udiskie - t & 

nm-applet &

volumeicon &

cbatticon -u 5 &

nm-applet &

nitrogen --restore & 

#barrier --no-tray --enable-crypto --name gladoncio --ip-addr 192.168.18.106 &