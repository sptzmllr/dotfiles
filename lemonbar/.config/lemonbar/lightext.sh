#!/bin/bash

. ./common.sh

fifo=${XDG_RUNTIME_DIR:-/tmp}/lemonbar.fifo

if [ ! -e "$fifo" ]; then
	exit 1
	#echo "exist"
fi

		
#echo "BRE%{B${color_hl2} $(xbacklight -get | cut -d'.' -f1)% %{B-}" > $fifo
for i in {1..20};
do
	echo "BRE%{B${color_bg2}} $(xbacklight -get | cut -d'.' -f1)% %{B-}" > $fifo
	sleep 0.5
done


echo "BRE" > $fifo
