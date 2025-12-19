#!/bin/bash


pass=$(gum input --header "共有するフォルダのパスを入力"  --header.foreground="206" --placeholder " 例：/home/sk/Videos") || exit 1

#cd "$pass"


inet=$(ip addr show wlan0 | grep "inet ")

ipa=$(echo "${inet#*inet }")
ipb=$(echo "${ipa%%/*}")

sleep 3 && qrencode -t UTF8 http://$ipb:7777/
echo "サーバーへのアドレス  http://$ipb:7777/"
echo "QRコードを読み取るとスマホからアクセスできます"
echo -e "\n"
tput setaf 3 && echo -e "サーバーを終了するには\nCtrl + C で終了"
tput sgr0
echo -e "\n"

(cd "$pass" && python3 -m http.server 7777)
