#!/usr/bin/env bash
# get_weather.sh

location=""

for i in {1..5}
do
    text=$(curl -s "wttr.in/$location?format=1")

    if [[ $? == 0 ]]
    then
        text=$(echo "$text")
        tooltip=$(curl -s "wttr.in/$location?format=4")
    if [[ $? == 0 ]]
    then
        tooltip=$(echo "$tooltip" | sed -E "s/\s+/ /g")
        echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
        exit
    fi
    fi
    sleep 2
done
echo "{\"text\":\"error\", \"tooltip\":\"error\"}"


