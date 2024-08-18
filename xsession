#!/bin/sh
# https://github.com/drduh/config/blob/master/xsession
# https://manpages.debian.org/bookworm/x11-common/Xsession.5.en.html
set -x
[ -f ~/.fehbg ] && /bin/sh ~/.fehbg &
#xidle &
#xinput --set-prop 10 'libinput Accel Speed' 0.5
xset b off
xsetroot -name "$(date '+%A %j') | $(uname -sv) "
exec /usr/local/bin/dwm
