#!/bin/bash

STATE_FILE="/tmp/waybar_clock_mode"

if [ ! -f "$STATE_FILE" ]; then
    echo "time" > "$STATE_FILE"
fi

if [ "$(cat $STATE_FILE)" == "date" ]; then
    echo "time" > "$STATE_FILE"
else
    echo "date" > "$STATE_FILE"
fi

# Waybar に信号を送って即座に更新させる（signal: 8 を設定する場合）
pkill -RTMIN+8 waybar
