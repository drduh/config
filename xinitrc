#!/bin/sh
[ -f ~/.fehbg ] && /bin/sh ~/.fehbg &
xsetroot -name "$(date '+%A %j') | $(uname -sv) "
exec /usr/local/bin/dwm
