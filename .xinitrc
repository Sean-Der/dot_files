#!/bin/sh
while true; do
  acpiout=$(LC_ALL=C acpiconf -i batt0)
  stat=$(echo $acpiout| awk '{print $44}')
  batt=$(echo $acpiout| awk '{print $47}')

  if [ ! $stat == "discharging" ]
  then
    batt=""
  fi

  xsetroot -name "$batt $(date +%R)"
  sleep 60
done &

cd ~
setxkbmap -layout us -variant dvp
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'keysym Caps_Lock = Control_L'
xmodmap -e 'add Control = Control_L'

xkbset m
xmodmap -e "keycode 128 = Pointer_Button2"
xmodmap -e "keycode 212 = Pointer_Button3"
xbindkeys

wmname LG3D &
nm-applet &
unclutter -idle 2 -noevents &
exec dwm

#xrandr --output LVDS1 --auto --output HDMI1 --auto --left-of LVDS1
#redshift &
