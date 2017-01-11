#!/usr/bin/env bash
while true; do
  acpiout=$(LC_ALL=C acpi -b)
  stat=$(echo $acpiout| awk '{print $3}' | sed '$s/,$//')
  batt=$(echo $acpiout| awk '{print $4}' | sed '$s/,$//')
  time=$(date +%R)
  email=$(/home/sean/bin/email)

  if [ $email != 0 ]; then
    email=`echo -e "\x04✉ $email\x01|"`
  else
    email="✉ $email |"
  fi

  if [ $stat == "Discharging" ]; then
    batt=`echo -e "\x03⚡ $batt\x01|  "`
  else
    batt=" ⚡ $batt | "
  fi

  xsetroot -name "$email$batt$time "
  sleep 60
done &

cd ~
setxkbmap -layout us -variant dvp
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'keysym Caps_Lock = Control_L'
xmodmap -e 'add Control = Control_L'
xset b off
xbindkeys
xrandr --output LVDS-1 --auto --output HDMI-1 --auto --above LVDS-1
eval $(killall ssh-agent; ssh-agent)
unclutter -idle 2 -noevents &
xautolock -time 10 -locker slock &
clipit &
gtk-redshift &
mpd &
nm-applet &
pasystray &
dunst &
compton --backend glx --vsync opengl-swc &
hsetroot -solid "#000000"
exec dwm
