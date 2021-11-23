#!/bin/bash

. ./common.sh

fifo=${XDG_RUNTIME_DIR:-/tmp}/lemonbar.fifo

if [ ! -e "$fifo" ]; then
	exit 1
	#echo "exist"
fi

fanspeed=$(sensors | awk '/fan1:/ {print $2}')

cpuload=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}' | cut -d'.' -f1)

if [[ ${fanspeed} == 0 ]]; then
	fansym="\ufd1b"
else
	fansym="\uf70f ${fanspeed} RPM"
fi
		
#echo "BRE%{B${color_hl2} $(xbacklight -get | cut -d'.' -f1)% %{B-}" > $fifo
#echo "VEX%{B${color_bg2}} $(pactl list sinks | awk '/\tVolume/ {print $5}') %{B-}" #> $fifo
echo "CEX%{B${color_bg2}} \ue266 ${cpuload}% $(cpupower frequency-info | awk '/asserted by call to kernel/ {print $4""$5}') \
$( sensors | awk '/Package id 0:/ {print $4}') \
\uf85a $( free -hg | awk '/Mem:/ {print $3}')/$( free -hg | awk '/Mem:/ {print $2}') \
${fansym} %{B-}" > $fifo

sleep 10

echo "CEX" > $fifo

