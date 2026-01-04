#!/bin/bash

STATE_FILE="/tmp/waybar_clock_mode"

if [ ! -f "$STATE_FILE" ]; then
    echo "time" > "$STATE_FILE"
fi

MODE=$(cat "$STATE_FILE")

if [ "$MODE" == "date" ]; then
    TEXT=$(date +' %Y-%m-%d')
else
    TEXT=$(date +' %H:%M')
fi

TOOLTIP=$(date +'%Y年%m月%d日 %H時%M分')
echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TOOLTIP\"}"