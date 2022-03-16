
#!/bin/sh

desktops=$(bspc query -D --names)
focused=$(bspc query -D --names -d focused)

for desktop in $desktops; do
	desktop=$(echo "$desktop")
	nodes=$(bspc query -N -d $desktop)

	if [ ! -z "$nodes" ]; then
		desktops=$(echo $desktops | sed "s/$desktop/%{F#ff0000}$desktop%{F-}/")
	fi

done
desktops=$(echo $desktops | sed "s/$focused/%{B#444444}%{+u}_$focused\_%{-u}%{B-}/")


echo $desktops | sed "s/_/ /g"
