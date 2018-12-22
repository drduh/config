#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/update-current.sh
host=cdn.openbsd.org
plat=amd64
vers=openbsd-64-base
printf "current version: "
ls -l /bsd.rd | awk '{print $6 " " $7}'
printf "latest update: "
curl -sq https://$host/pub/OpenBSD/snapshots/$plat/ | grep "bsd.rd" | awk '{print $3}'
action=""
while [[ -z "${action}" ]] ;
  do read -n 1 -p "Proceed? " action
done
if [[ "${action}" =~ ^([yY])$ ]] ; then
  cp bsd.rd -v bsd.rd.$(date +%F) 2>/dev/null
  curl -LfsqO https://$host/pub/OpenBSD/snapshots/$plat/bsd.rd && \
  curl -LfsqO https://$host/pub/OpenBSD/snapshots/$plat/SHA256 && \
  curl -LfsqO https://$host/pub/OpenBSD/snapshots/$plat/SHA256.sig && \
  signify -Cp /etc/signify/$vers.pub -x SHA256.sig bsd.rd && \
  doas cp -v ./bsd.rd /bsd.rd && doas chown root:wheel /bsd.rd
else
  exit 0
fi
echo "reboot into /bsd.rd to upgrade"
