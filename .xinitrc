#!/usr/bin/env bash

while true; do
  acpiout=$(LC_ALL=C acpi -b)
  stat=$(echo $acpiout| awk '{print $3}' | sed '$s/,$//')
  batt=$(echo $acpiout| awk '{print $4}' | sed '$s/,$//')
  time=$(date +%R)

  if [ $stat == "Discharging" ]; then
    batt=`echo -e "\x03⚡ $batt\x01|  "`
  else
    batt=" ⚡ $batt | "
  fi

  xsetroot -name "$batt$time "
  sleep 60
done &



cd ~
setxkbmap -layout us -variant dvp
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'keysym Caps_Lock = Control_L'
xmodmap -e 'add Control = Control_L'
xset b off
eval $(killall ssh-agent; ssh-agent)
mpd
unclutter -idle 2 -noevents &
xautolock -time 10 -locker slock &
clipit &
gtk-redshift &
hsetroot -solid "#000000"
exec dwm
