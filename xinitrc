#!/bin/bash

[ -f ~/.fehbg ] && sh ~/.fehbg &

while : ; do
  xsetroot -name "$(uptime | sed 's/.*age: //g') | $(date '+%A %h %d %H:%M')"
  sleep 60
done &

exec dwm
