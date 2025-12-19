#!/bin/sh

# 二重起動チェック
if [ $$ != `pgrep -fo $0` ]; then
 killall pavucontrol

else
 pavucontrol
 
fi
