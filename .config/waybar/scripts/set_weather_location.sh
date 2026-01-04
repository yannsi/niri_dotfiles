#!/bin/bash

CONFIG_FILE="$HOME/.config/waybar/scripts/weather_location.txt"

# 現在の設定を読み込む
CURRENT_CITY=$(cat "$CONFIG_FILE" 2>/dev/null || echo "Tokyo")

# Zenityで入力ダイアログを表示
NEW_CITY=$(zenity --entry --title="天気予報の地域設定" --text="表示したい都市名を入力してください（英語推奨）\n例: Tokyo, Osaka, New_York, London" --entry-text="$CURRENT_CITY")

# キャンセルされた場合は終了
if [ -z "$NEW_CITY" ]; then
    exit 0
fi

# 入力内容をファイルに保存
echo "$NEW_CITY" > "$CONFIG_FILE"

# 通知を表示（オプション）
notify-send "Weather Update" "Location set to: $NEW_CITY"

# Waybarをリロードせずにモジュールだけ更新できればベストだが、
# execスクリプト系は次回実行を待つか、Waybar全体のリロードが必要な場合が多い。
# ここではユーザーに反映を待ってもらうか、必要なら手動リロードを促す形にする。
# あるいは、pkill -SIGRTMIN+x waybar を使って即時更新させる仕組みもあるが、
# configの修正が必要になるため今回はシンプルにしておく。
