#!/bin/bash

repo_list_file="repo_liste.txt"
count=true
print=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --repos) shift; repo_list_file="$1";;
        --count) count=true;; 
        --print) print=true;;
        *) echo "Unbekanntes Argument: $1"; exit 1;;
    esac
    shift
done


repos=()

while IFS= read -r line; do 
	repos+=("$line")
done< "$repo_list_file"

total=0
text=""

# Iteriere über jedes Repository
for repo in "${repos[@]}"
do
    # Extrahiere den Repo-Namen (letzter Teil des Pfads)
    repo_name=$(basename "$repo")

    # Führe 'git status' im Repository aus und lese die Ergebnisse
    status_output=$(git -C "$repo" status -s)

    # Zähle die Anzahl der modifizierten und unverfolgten Dateien
    modified_count=$(echo "$status_output" | grep -c "M")
    untracked_count=$(echo "$status_output" | grep -c "^??")
    added_count=$(echo "$status_output" | grep -c "A")
    deleted_count=$(echo "$status_output" | grep -c "^D")
    renamed_count=$(echo "$status_output" | grep -c "^R")
    copied_count=$(echo "$status_output" | grep -c "^C")

	temp="$total"
	
	((total += modified_count))
	((total += untracked_count))
	((total += added_count))
	((total += deleted_count))
	((total += renamed_count))
	((total += copied_count))

	if [ "$total" -gt "$temp" ]; then 
		new=$(echo "$repo" | rev | cut -d'/' -f1 | rev)
		if [ -z "$text" ]; then
			text="${new}"
		else
			text="${text} ${new}"
		fi
	fi

    # Gib die Ergebnisse aus
    #echo "Repository: $repo_name"
    #echo "Anzahl der modifizierten Dateien: $modified_count"
    #echo "Anzahl der unverfolgten Dateien: $untracked_count"
    #echo "Anzahl der hinzugefügten Dateien: $added_count"
    #echo "Anzahl der gelöschten Dateien: $deleted_count"
    #echo "Anzahl der umbenannten Dateien: $renamed_count"
    #echo "Anzahl der kopierten Dateien: $copied_count"
    #echo "-----"
done
if [ "$count" == true ]; then
    # Hier können Sie die Logik hinzufügen, um die Anzahl der Veränderungen zu verarbeiten
	echo "$total" 
fi

# Prüfen, ob die Option --print angegeben wurde
if [ "$print" == true ]; then
    # Hier können Sie den gewünschten String ausgeben
    echo "$text"
fi

