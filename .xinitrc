#!/usr/bin/env bash
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
exec i3
