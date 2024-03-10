#!/bin/sh
# https://github.com/drduh/config/blob/master/xsession
# https://manpages.debian.org/bookworm/x11-common/Xsession.5.en.html
set -x
[ -f ~/.fehbg ] && /bin/sh ~/.fehbg &
#xidle &
xset b off
xsetroot -name "$(date '+%A %j') | $(uname -sv) "
exec /usr/local/bin/dwm
