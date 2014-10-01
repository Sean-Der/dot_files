#!/bin/sh
while true; do
  acpiout=$(LC_ALL=C acpi -b)
  stat=$(echo $acpiout| awk '{print $3}' | sed '$s/,$//')
  batt=$(echo $acpiout| awk '{print $4}' | sed '$s/,$//')

  if [ ! $stat = "Discharging" ]
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

xmodmap -e "keycode 128 = Pointer_Button2"
xmodmap -e "keycode 212 = Pointer_Button3"
xkbset exp -m
xkbset m
xbindkeys

eval $(/usr/bin/killall ssh-agent; /usr/bin/ssh-agent)

wmname LG3D &
nm-applet &
unclutter -idle 2 -noevents &
mpd
exec dwm

#xrandr --output LVDS1 --auto --output HDMI1 --auto --left-of LVDS1
#redshift &
