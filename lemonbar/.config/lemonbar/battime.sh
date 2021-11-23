#!/bin/bash

fifo=${XDG_RUNTIME_DIR:-/tmp}/lemonbar.fifo

if [ ! -e "$fifo" ]; then
	exit 1
	#echo "exist"
fi

. ./common.sh
stat=$(cat /sys/class/power_supply/BAT0/status)


for i in {1..20}
do
	en_full=$(cat /sys/class/power_supply/BAT0/energy_full)
	en_now=$(cat /sys/class/power_supply/BAT0/energy_now)
	pw_now=$(cat /sys/class/power_supply/BAT0/power_now)

	pw_watt="$(echo "scale=2; $pw_now/1000000" | bc)W"

	if [[ "${stat}" == "Discharging" ]]; then
		sec=$(echo "scale=6; $en_now / $pw_now * 60^2 " | bc )
		human_time=$( date -d@${sec} -u +%H:%M:%S )
		echo "BTM%{B$color_bg2}Empty: ${human_time} ${pw_watt} %{B-}" > $fifo
	elif [[ "${stat}" == "Charging" ]]; then
		sec=$(echo "scale=6; ( $en_full-$en_now )/ $pw_now * 60^2 " | bc )
		human_time=$( date -d@${sec} -u +%H:%M:%S )
		echo "BTM%{B$color_bg2}Full: ${human_time} ${pw_watt} %{B-}" > $fifo
	else
		echo "BTM%{B$color_bg2} ${pw_watt} %{B-}" > $fifo
	fi

	sleep 0.5
done

echo "BTM" > $fifo
exit

#elif [[ "${stat}" == "Discharging" ]]; then
#	sec=$(echo "scale=6; ( $en_full-$en_now )/ $pw_now * 60^2 " | bc )

#	human_time=$( date -d@${sec} -u +%H:%M:%S )
##	echo "BTM ${human_time}"
#sec=$(echo "scale=6; (48150000-39170000)/12947000 *60^2" | bc)

#echo "${sec}"
#date -d@${sec} -u +%H:%M:%S
