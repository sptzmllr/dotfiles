#!/bin/bash

. ./common.sh

fifo=${XDG_RUNTIME_DIR:-/tmp}/lemonbar.fifo

if [ ! -e "$fifo" ]; then
	exit 1
	#echo "exist"
fi

		
#echo "BRE%{B${color_hl2} $(xbacklight -get | cut -d'.' -f1)% %{B-}" > $fifo
#echo "VEX%{B${color_bg2}} $(pactl list sinks | awk '/\tVolume/ {print $5}') %{B-}" #> $fifo
for i in {1..40}
do
	echo "VEX%{B${color_bg2}} $(pactl list sinks | grep -A7 $(pactl info | awk '/Default Sink:/ {print $3}') | awk '/\tVolume/ {print $5}') %{B-}" > $fifo
	sleep 0.25
done

echo "VEX" > $fifo

