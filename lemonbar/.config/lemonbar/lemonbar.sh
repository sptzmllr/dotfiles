#!/bin/bash

cd $(dirname -- $0)

. ./common.sh

fifo=${XDG_RUNTIME_DIR:-/tmp}/lemonbar.fifo
test -e $fifo && rm $fifo
mkfifo $fifo

trap 'pkill lemonbar; kill $(jobs -p)' EXIT

# Date
while :; do
	date "+DAT%d.%m %H:%M" > $fifo
    sleep 0.5m;
done &

# BSPWM desktops
while read -r line; do
    echo "DES$(bspc_desktops)" > $fifo
done < <(bspc subscribe desktop) &

# Xtitle output
while read -r line; do
	#xtitle -f 'TIT%s\n' > $fifo
	xtitle -f 'TIT%s\n' > $fifo
	#sleep 0.1
done < <(bspc subscribe node) &

# pacman Packages to update
while :; do
	packupdate=$(checkupdates | wc -l)

	if [[ packupdate -gt 0 ]]; then
		echo "PAC\uf8d3 ${packupdate}" > $fifo
	else
		echo "PAC" > $fifo
	fi

	sleep 10m;
done &

while :; do
	service_count=0
	message_count=0
	signal=$(xdotool search --name Signal)
	if [ $? -eq 0 ]; then
		service_count=$((service_count + 1))
		signal_count=$(xprop -id $(xdotool search --name Signal | head -1) | grep "NET_WM_NAME" | tr -d '()"' | awk '{print $4}')
		message_count=$((message_count + signal_count))

	fi

	matrix=$(xdotool search --name Element)
	if [ $? -eq 0 ]; then
		service_count=$((service_count + 1))
		element_count=$(xprop -id $(xdotool search --name Element | head -1) | grep "NET_WM_NAME" | tr -d '[]"' | awk '{print $4}')
		if [[ "${element_count}" == "|" ]]; then
			element_count=0	
		fi
		message_count=$((message_count + element_count))
	fi

	# elif [[ matrix -eq 1 ]]; then
	#	service_count++
#	else

	# on the glyphes currently i use the checkbox glyphe from nerdfont
	# this is extendable to one or two more messagin services 
	# Other possible glyphes from nerdfont are: checkbox, dice,
	# numeric, shield, moon
	unread_msg=""
	if [[ message_count -gt 0 ]]; then
		unread_msg=" ${message_count}"
	fi

	chatglyphe="\uf860"
	if [[ service_count -gt 0 ]]; then
		chatglyphe="\uf868"
	fi
		
		echo "INS${chatglyphe}${unread_msg}" > $fifo


	sleep 1m;
done &

# Unread Mutt Mail
while :; do
	unread=$(notmuch count tag:unread)

	if [[ $unread -gt 0 ]]; then
		envelop="\uf0e0"
	else
		envelop="\uf2b6"
		unread=""
	fi

    echo "MAL${envelop} ${unread}" > $fifo
	
	sleep 5;
done &

# Unread RSS Newsboat
#while :; do
#	feed=$(newsboat -x print-unread | awk '{print $1}')

##	if [[ $feed -gt 0 ]]; then
#		rss="\uf96b"
#	else
#		rss="\uf96b"
#		feed=""
#	fi
#
#	echo "RSS${rss} ${feed}" > $fifo
#
#	sleep 5;
#done &

# Brightness
while :; do
	brightness=$(xbacklight -get | cut -d'.' -f1)
	if [[ ${bri_msg} == "1" ]]; then
		brightnessmsg=" $brightness"
	fi

	if [[ $brightness -gt 75 ]]; then
		sun="\uf5df"
	elif [ $brightness -gt 50 ]; then
		sun="\uf5de"
	elif [ $brightness -gt 25 ]; then
		sun="\uf5dc"
	else
		sun="\uf5dd"
	fi

    echo "BRI${sun}${brightnessmsg}" > $fifo
    sleep 0.5
done &

# Specs
while :; do
	#cpu_temp=$( sensors | awk '/Package id 0:/ {print $4}' )

	cpu_icon="\uf080"

	echo "CPU${cpu_icon}" > $fifo

	sleep 5
done &

# Bluetooth
while :; do
	bt_status=$(bluetoothctl show | awk '/Powered:/ {print $2}')


	if [[ "${bt_status}" == "yes" ]]; then
		bt_icon="\uf5ae"	

		if ! bluetoothctl info | grep -q "Missing"; then
			bt_icon="\uf5b0"
		fi
	else
		bt_icon="\uf5b1"
	fi

	echo "BTH${bt_icon}" > $fifo

	sleep 5
done &

# Settings
#while :; do
#
#	echo "SET\uf992" > $fifo
#	sleep 5
#done &
#echo "SET\uf992" > $fifo

# Volume
while read -r line; do
    #current=$(pactl list sinks | awk '/\tVolume/ {print $5}')
	current=$(pactl list sinks | grep -A7 $(pactl info | awk '/Default Sink:/ {print $3}') | awk '/\tVolume/ {print $5}')
    current_n=$(cut -d'%' -f1 <<< $current)

    if [[ "$(pactl list sinks | awk '/Mute:/ {print $2}')" == "yes" ]]; then
        icon="\ufc5d"
    elif [ $current_n -gt 66 ]; then
        icon="\ufa7d"
    elif [ $current_n -gt 33 ]; then
        icon="\ufa7f"
    #elif [ $current_n < 25 ]; then
    else
        icon="\ufa7e"
    fi

    echo "VOL${icon}" > $fifo

    sleep 0.5
done < <(pactl subscribe) &

# Battery
while :; do
	capacity=$(cat /sys/class/power_supply/BAT0/capacity)
	charge=$(cat /sys/class/power_supply/AC/online)

	if [[ ${charge} == 1 ]]; then
		ac="\ufba3"
	else
		ac=""
	fi

	if [ $capacity -gt 90 ]; then
		baticon="\uf240"
	elif [ $capacity -gt 75 ]; then
		baticon="\uf241"
	elif [ $capacity -gt 50 ]; then
		baticon="\uf242"
	elif [ $capacity -gt 25 ]; then
		baticon="\uf243"
	else
		baticon="\uf244"
	fi

    echo "BAT${ac} ${baticon} ${capacity}%" > $fifo
    sleep 10
done &

tail -f $fifo | $(dirname -- $0)/parser.sh | lemonbar \
	-p \
	-a 23 \
	-g "x25+0+0" \
	-B "${color_bg}" \
	-F "${color_fg}" \
	-f "Roboto Mono:size=11" \
	-f "RobotoMono Nerd Font:size=11" \
	| sh
