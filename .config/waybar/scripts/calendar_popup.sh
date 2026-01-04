#!/bin/bash
# カレンダーを表示し、何かキーを押すと閉じる
alacritty --title "Calendar" -e bash -c "cal; read -n 1 -s -r -p 'Press any key to close...'"
