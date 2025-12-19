#!/bin/bash

que=$(zenity --question --text="壁紙を設定します")

if [ $? -eq 1 ]; then
exit 0
fi

wall=$(zenity --file-selection --filename=$HOME/ --text="壁紙を選んでください")

if [ -n "$wall" ]; then
 echo '#!/bin/bash' > $HOME/.config/waybar/scripts/wallpaper
 echo "swaybg -i '"$wall"'" >> $HOME/.config/waybar/scripts/wallpaper
 killall swaybg
 swaybg -i "$wall" & exit 0

else
 exit 1
fi
