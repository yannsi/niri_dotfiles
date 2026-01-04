#!/bin/bash

# rofi が起動しているか確認
if pgrep -x "rofi" > /dev/null; then
    # 起動していれば終了させる
    pkill -x rofi
else
    # 起動していなければパワーメニューを表示する
    rofi -show power-menu -modi power-menu:$HOME/.config/waybar/scripts/rofi-power-menu -theme $HOME/.config/rofi/power-menu.rasi
fi
