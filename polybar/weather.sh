#/bin/sh

res="$(curl -s -L wttr.in/France+Argenteuil?format=1)"
# res="$(curl -s -L wttr.in/France+Argenteuil?format=1)"
echo ${res##* }
