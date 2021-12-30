#!/usr/bin/env bash

while true; do
  acpiout=$(LC_ALL=C acpi -b)
  stat=$(echo $acpiout| awk '{print $3}' | sed '$s/,$//')
  batt=$(echo $acpiout| awk '{print $4}' | sed '$s/,$//')
  batt_escape='\x01'

  if [ $stat == "Discharging" ]; then
    if (( ${batt::-1} < 10 )); then
      batt_escape='\x04'
    else
      batt_escape='\x03'
    fi
  fi

  time=$(date +%R)
  setroot=$(echo -e "${batt_escape} ⚡ ${batt} \x01| ${time}")
  xsetroot -name "$setroot"  sleep 60
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
