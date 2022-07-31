#!/bin/bash

theme="nord"

case $theme in
    "dracula")
        color_bg="#282a36"
        color_fg="#f8f8f2"
        color_hl1="#6272a4"
        color_hl2="#bd93f9"
        ;;
    *) # Default to Nord
        color_bg="#2e3440"
        color_bg2="#434c5e"
        color_fg="#d8dee9"
        color_hl1="#5e81ac"
        color_hl2="#81a1c1"
        #color_hl2="#8fbcbb"
		color_polar1="#2e3440"
		color_polar2="#3b4252"
		color_polar3="#434c5e"
		color_polar4="#4c566a"
        ;;
esac

bri_msg="0"

bspc_desktops() {
	# query all desktops and occupied desktops
    desktops=$(bspc query -D --names)
	occupied=$(bspc query -D -d .occupied --names)
    buf=""

	# check every element in the desktop array
    for d in ${desktops[@]}; do

		# First set the number foreground to gray (not occupied is default)
		number="%{F${color_bg2}}${d}%{F-}"
		# check ever element in the occupied array. If if matches, remove the
		# foreground so it is not grayed out anymore
		for o in ${occupied[@]}; do 
			if [[ ${o} -eq ${d} ]]; then
				number="${d}"
			fi
		done

		# check the current desktopnumber if it is focused and change background
        if [[ "$(bspc query -D -d focused --names)" == "${d}" ]]; then
            buf="${buf}%{B${color_hl2}}%{A:bspc desktop -f ${d} &:} ${number} %{A}%{B-}"
		else
            buf="${buf}%{A:bspc desktop -f ${d} &:} ${number} %{A}"
            #buf="${buf} ${number} "
		fi
    done

    echo "${buf}"
}
