#!/bin/sh
while true; do
  acpiout=$(acpiconf -i batt0)
  stat=$(echo $acpiout| awk '{print $45}')
  batt=$(echo $acpiout| awk '{print $48}')

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
xset b off
xbindkeys
xrandr --output LVDS1 --auto --output VGA1 --auto --above LVDS1
eval $(/usr/bin/killall ssh-agent; /usr/bin/ssh-agent)
wmname LG3D &
unclutter -idle 2 -noevents &
exec dwm

#redshift &
