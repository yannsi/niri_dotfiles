#!/bin/bash

location=$(zenity --entry --text="気象情報を表示する場所を設定してください。\n※ 初期値は「沖縄」に設定されています\n例：（東京・座間味・ニューヨーク）")

if [ -n "$location" ]; then
sed -i "4c location="$location"" $HOME/.config/waybar/scripts/get_weather.sh 

killall waybar && waybar

else
exit 1

fi

