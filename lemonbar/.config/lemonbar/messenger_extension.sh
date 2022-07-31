#!/bin/bash
#source colors etc..
. ./common.sh


fifo=${XDG_RUNTIME_DIR:-/tmp}/lemonbar.fifo

if [ ! -e "$fifo" ]; then
	exit 1
	#echo "exist"
fi

		
#echo "BRE%{B${color_hl2} $(xbacklight -get | cut -d'.' -f1)% %{B-}" > $fifo
#echo "VEX%{B${color_bg2}} $(pactl list sinks | awk '/\tVolume/ {print $5}') %{B-}" #> $fifo

icon_online="\uf838"
icon_offline="\uf839"




	# check if signal is online
	# search for the process and then check the las return code 0 = exit normal
	signal_message="Signal ${icon_offline}"

	signal=$(xdotool search --name Signal)

	if [ $? -eq 0 ]; then

		# create empty message
		signal_count_msg=""
		signal_count=$(xprop -id $(xdotool search --name Signal | head -1) | grep "NET_WM_NAME" | tr -d '()"' | awk '{print $4}')

		if [[ signal_count -gt 0 ]]; then
			signal_count_msg=" [${signal_count}]"
		fi

		signal_desktop=$(xprop -id $(xdotool search --name Signal | head -1) | grep "_NET_WM_DESKTOP" | awk '{print $3}')
		signal_desktop=$((signal_desktop + 1))
	
		signal_message="%{A:bspc desktop -f ${signal_desktop} &:} Signal ${icon_online}${signal_count_msg}%{A}"
	fi 

	# check if signal is online
	# search for the process and then check the las return code 0 = exit normal
	element_message="Element ${icon_offline}"

	element=$(xdotool search --name Element)

	if [ $? -eq 0 ]; then

		# create empty message
		element_count_msg=""
		element_count=$(xprop -id $(xdotool search --name Element | head -1) | grep "NET_WM_NAME" | tr -d '[]"' | awk '{print $4}')
		if [[ "${element_count}" == "|" ]]; then
			element_count=0	
		fi
		if [[ element_count -gt 0 ]]; then
			element_count_msg=" [${element_count}]"
		fi

		element_desktop=$(xprop -id $(xdotool search --name Element | head -1) | grep "_NET_WM_DESKTOP" | awk '{print $3}')
		element_desktop=$((element_desktop + 1))
	
		element_message="%{A:bspc desktop -f ${element_desktop} &:} Element ${icon_online}${element_count_msg}%{A}"
	fi 

	#echo ${signal_message}
	#echo ${element_message}
	# count the messages

	echo "INX%{B${color_bg2}}${signal_message} ${element_message} %{B-}" > $fifo
	sleep 10

echo "INX" > $fifo

	#matrix=$(xdotool search --name Element)
	# if [ $? -eq 0 ]; then
	#	matrix_status="\uf838"
	# else
	#	matrix_status="\uf839"
	# fi 
	
	# element_count=$(xprop -id $(xdotool search --name Element | head -1) | grep "NET_WM_NAME" | tr -d '[]"' | awk '{print $4}')
	#if [[ "${element_count}" == "|" ]]; then
	#	element_count=0	
	# fi
