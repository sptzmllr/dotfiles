#!/bin/bash

fifo=${XDG_RUNTIME_DIR:-/tmp}/lemonbar.fifo

if [ ! -e "$fifo" ]; then
	exit 1
	#echo "exist"
fi

. ./common.sh

echo "SET%{B$color_bg2}%{A:sudo shutdown now &:}\uf011 shutdown %{A}%{A:sudo reboot now &:} \uf021 reboot%{A}%{A:xsecurelock &:} \uf023 lock%{A} %{B-}" > $fifo

sleep 10

echo "SET" > $fifo
