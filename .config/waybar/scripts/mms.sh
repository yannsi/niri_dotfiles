#!/bin/bash
clear

ipt=$(gum input --header="YouTubeを検索します(Ctrl + Cで終了)" --header.foreground="199" --placeholder="検索するフレーズを入力(曲名等)")

if [ -z "$ipt" ]; then
exit 0
fi

tput setaf 3 && echo "検索中・・・"
tput sgr0

yt-dlp ytsearch10:"$ipt" --get-id --get-title --no-warnings | pv | tee $HOME/.config/waybar/scripts/mms.txt > /dev/null

sed -i "s/\[//g" $HOME/.config/waybar/scripts/mms.txt ; sed -i "s/]//g" $HOME/.config/waybar/scripts/mms.txt

while :
do

clear

chs=$(sed 'n; d' $HOME/.config/waybar/scripts/mms.txt | gum choose --header="矢印キーで選択" --header.foreground="180")

if [ "$?" -eq 130 ]; then #130=(128+シグナル番号)
exit 0
fi

id=$(grep -x -A 1 "$chs" $HOME/.config/waybar/scripts/mms.txt | sed -n 2P)

yt-dlp -f b https://www.youtube.com/watch?v="$id" --no-warnings -g | xargs mpv || exit

gum confirm "終了しますか？" && exit 0

done

exit 0
