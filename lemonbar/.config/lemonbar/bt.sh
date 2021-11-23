#!/bin/bash

fifo=${XDG_RUNTIME_DIR:-/tmp}/lemonbar.fifo

if [ ! -e "$fifo" ]; then
	exit 1
	#echo "exist"
fi

. ./common.sh

#while [[ $# -gt 0 ]]; do
#	key="$1"

#	case $key in
#		-t|--toggle)
#		echo "lmao"
#		;;
#	esac
#done

declare output="BTE%{B$color_bg2}"

bluetoothctl devices | while read -r line ; do
	btmac=$(echo $line | awk '{print $2}')	

	macstate=$(bluetoothctl info $btmac | awk '/Connected:/ {print $2}')
	devinfo=$( bluetoothctl info $btmac | awk '/Icon:/ {print $2}')
	
	if [[ "${macstate}" == "yes" ]]; then

		devicon=""
		if [[ "${devinfo}" == "audio-card" ]]; then
			devicon="\uf7cd"
		elif [[ "${devinfo}" == "input-mouse" ]]; then
			devicon="\uf87c"
		fi
		
		output="${output} ${devicon}$(echo $line | awk '{$1=$2=""; print $0}') "

	fi

	# String lenght prototype
	#if [[ ${#output} -ge 1 ]]; then
	#	output="${output} No Devices"
	#fi
	
	echo "$output %{B-} " > $fifo
done


sleep 10

echo "BTE" > $fifo

#echo $btout
