#!/bin/sh
# https://github.com/drduh/config/blob/master/xsession
[ -f ~/.fehbg ] && /bin/sh ~/.fehbg &
xidle &
xset b off
xsetroot -name "$(date '+%A %j') | $(uname -sv) "
exec /usr/local/bin/dwm
