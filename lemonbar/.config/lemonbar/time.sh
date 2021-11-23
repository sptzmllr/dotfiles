sec=$(echo "scale=6; (48150000-39170000)/12947000 *60^2" | bc)

echo "${sec}"
date -d@${sec} -u +%H:%M:%S
