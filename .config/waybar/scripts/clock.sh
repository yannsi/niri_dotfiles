#!/bin/bash
TIME=$(date +' %H:%M  %Y-%m-%d')
TOOLTIP=$(date +'%Y年%m月%d日 %H時%M分')
echo "{\"text\": \"$TIME\", \"tooltip\": \"$TOOLTIP\"}"
