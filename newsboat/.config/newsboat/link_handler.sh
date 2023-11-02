#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Falsche Anzahl an Argumenten. Bitte geben Sie ein Wort und einen Link an."
    exit 1
fi

video_ytdl_720=("youtube.com" "youtu.be") 
video_ytdl=("vimeo.com" "instagram.com/reel")
video_raw=("cdn.media.ccc.de" "media.tagesschau.de")


linktype=$1
link=$2

check_domain() {
	local link=$1

	for domain in "${video_ytdl_720[@]}"; do 
		if [[ $link == *"$domain"* ]]; then 
 			linktype="video-ytdl_720"
			return
		fi 
	done

	for domain in "${video_ytdl[@]}"; do 
		if [[ $link == *"$domain"* ]]; then 
 			linktype="video-ytdl"
			return
		fi 
	done

	for domain in "${video_raw[@]}"; do 
		if [[ $link == *"$domain"* ]]; then 
 			linktype="video"
			return
		fi 
	done

}



check_domain "$link"

echo "Das eingegebene Wort ist: $linktype"
echo "Der eingegebene Link ist: $link"

case $linktype in 
	"video-ytdl_720")
		yt-dlp $link -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' -o - | mpv --autofit-larger=100%x100% -
		;;
	"video-ytdl")
		yt-dlp $link -o - | mpv --autofit-larger=100%x100% -
		;;
	"video")
		mpv --autofit-larger=100%x100% $link
		;;
	"image")
		feh --auto-zoom --image-bg black $link 
		;;
	*)
		firefox $link 
		;;
esac

# Öffnen des Links
#xdg-open "$link"  # xdg-open öffnet den Link mit dem Standardprogramm auf dem System
