#!/bin/bash

fifo=${XDG_RUNTIME_DIR:-/tmp}/lemonbar.fifo

if [ ! -e "$fifo" ]; then
	exit 1
	#echo "exist"
fi

. ./common.sh

declare output="SET%{B$color_bg2} %{A:./screenmenu.sh} \uf992 %{A}\uf8df \uf925  "


echo "$output %{B-} " > $fifo

sleep 10

echo "BTE" > $fifo
