#!/bin/sh
while true; do
	batt=$(LC_ALL=C acpi -b)
	
	case $batt in
	*Discharging*)
		batt="${batt#* * * }"
		batt="${batt%%, *} "
		;;
	*)
		batt=""
		;;
	esac
	xsetroot -name "$batt$(date +%R)"

	sleep 60
done &

cd ~
xrandr --output LVDS1 --auto --output VGA1 --auto --left-of LVDS1
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
#wmname LG3D &
xrdb -merge ~/.Xresources &
unclutter -display :0 -root -idle 1 -jitter 10 -noevents &
dunst -nb black -nf blue &
#redshift -l 39.2:-84.5 &
exec dwm
