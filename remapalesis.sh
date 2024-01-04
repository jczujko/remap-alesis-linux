#!/bin/bash
set -m

if ! command -v aconnect &> /dev/null
then
	echo "aconnect not found, install alsa-utils first"
	exit 1
fi	

declare -a inputs_array
declare -a outputs_array
declare -i current_client
declare  sender
declare  receiver 

remapper &

while IFS= read -r line; do
	result=$(echo "$line" | grep -e ^client)
	if [ -n "$result" ]; then
                current_client=$(echo "$result" | sed 's@^[^0-9]*\([0-9]\+\).*@\1@' )
        else
                inputs_array+=("$current_client:$(echo "$line" | xargs)")
        fi
done < <(aconnect -i)

while IFS= read -r line; do
        result=$(echo "$line" | grep -e ^client)
        if [ -n "$result" ]; then
                current_client=$(echo "$result" | sed 's@^[^0-9]*\([0-9]\+\).*@\1@' )
        else
                outputs_array+=("$current_client:$(echo "$line" | xargs)")
        fi
done < <(aconnect -o)


PS3="Select your MIDI drum kit: "
select item in "${inputs_array[@]}"
do
        sender=$(echo "$item" | grep -o "[0-9]\+:[0-9]\+" )
        echo "Selected drum kit: $sender"
        break
done


PS3="Select remapper: "
select item in "${outputs_array[@]}"
do
        receiver=$(echo "$item" | grep -o "[0-9]\+:[0-9]\+" )
        echo "Selected remapper: $receiver"
        break
done


command aconnect "$sender" "$receiver"

echo "Remapper running, terminate when done playing"
fg
