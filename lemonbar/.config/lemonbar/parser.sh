#!/bin/bash

cd $(dirname -- $0)

. ./common.sh

desktop="$(bspc_desktops)"

while read -r line; do
    case $line in
      #  DAT*)
      #      date="%{B${color_hl1}}   ${line#???}   %{B-}"
      #      ;;
        DES*)
            desktop="${line#???}"
            ;;
		TIT*)
			title="${line#???}"
			;;
		PAC*)
			pac="${line#???}"
			;;
		INS*)
			chat="${line#???}"
			;;
		MAL*)
			mail="${line#???}"
			;;
		RSS*)
			rss="${line#???}"
			;;
        BRI*)
            brightness="${line#???}"
            ;;
        BRE*)
			brightness_ext=$( echo $line | cut -c 15-)
			brightness_strt=$( echo "${line#???}" | cut -c -11)
            ;;
 		BRS*)
			if [[ ${line#???} == 1 ]]; then
				bri_msg=1
			fi
			;;
        VOL*)
            volume="${line#???}"
            ;;
        VEX*)
            #volume_ext="${line#???}"
			volume_ext=$( echo $line | cut -c 15- )
			volume_strt=$( echo "${line#???}" | cut -c -11 )
            ;;
        BAT*)
            battery="${line#???}"
            ;;
        BTM*)
			bat_end=$( echo $line | cut -c 15- )
			bat_beg=$( echo "${line#???}" | cut -c -11 )
            ;;
        DAT*)
            date="${line#???}"
            ;;
        BTH*)
            bluetooth="${line#???}"
			;;
        CPU*)
            cpu="${line#???}"
			;;
		CEX*)
			cpu_ext=$( echo $line | cut -c 15-)
			cpu_strt=$( echo "${line#???}" | cut -c -11 )
            ;;
		BTE*)
			bluetooth_ext=$( echo $line | cut -c 15-)
			bluetooth_strt=$( echo "${line#???}" | cut -c -11 )
			#bluetooth_ext="${line#???}"
            ;;
		#SET*)
		#	settings="${line#???}"
		#	;;
        *) ;;
    esac

    echo -e "%{l}${desktop} \
		%{B${color_hl2}} ${title} %{B-} \
		%{r}\
		${pac}\
		${bluetooth_strt}\
		%{A:./bt.sh &:} ${bluetooth} %{A}\
		%{A:alacritty -e "bluetoothctl" &:}${bluetooth_ext}%{A}\
		%{A:alacritty -e "neomutt" &:} ${mail} %{A}\
		%{A:bspc desktop -f 7 &:} ${chat} %{A}\
		%{A:alacritty -e "newsboat" &:} ${rss} %{A}\
		${brightness_strt}\
		%{A:./lightext.sh &:} ${brightness} %{A}${brightness_ext}\
		${volume_strt}\
		%{A:./volext.sh &:} ${volume} %{A}\
		%{A:pavucontrol &:}${volume_ext}%{A}\
		${cpu_strt}\
		%{A:./specs.sh &:} ${cpu} %{A}\
		${cpu_ext}\
		${bat_beg}\
		%{A:./battime.sh &:} ${battery} %{A}${bat_end}  ${date} \
		%{A:./settings.sh &:} \uf992 %{A} "
done
		#%{r} %{A:urxvt -e "bluetoothctl" &:}${bluetooth}${bluetoothext}%{A}  \
