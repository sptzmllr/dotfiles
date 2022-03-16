#!/bin/sh

fifo=${XDG_RUNTIME_DIR:-/tmpp}/lemonbar.fifo

if [ ! -e "$fifo" ]; then
	exit 1
	#echo "exist"
fi

declare optput="BTW%{B$color_bg2}"

output="${optput} \uf004"


. ./common.sh
