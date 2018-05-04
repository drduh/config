#!/bin/bash
#
#sudo ifconfig wlan1 hw ether $(openssl rand -hex 6 | sed 's%\(..\)%\1:%g; s%.$%%')

[ -f ~/.fehbg ] && sh ~/.fehbg &

while : ; do
  xsetroot -name "$(uptime | sed 's/.*: //g') | $(date '+%A %h %d %H:%M')"
  sleep 60
done &

exec dwm
