#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/update-current.sh
host=cdn.openbsd.org
plat=amd64
vers=openbsd-64-base
printf "current version: "
stat -f "%Sm" -t "%d-%h-%Y" /bsd.rd
printf "latest version: "
curl -sq https://$host/pub/OpenBSD/snapshots/$plat/ | grep "bsd.rd" | awk '{print $3}'
action=""
while [[ -z "${action}" ]] ;
  do read -n 1 -p "Proceed? " action
done
printf "\n"
if [[ "${action}" =~ ^([yY])$ ]] ; then
  doas cp /bsd.rd ~/bsd.rd.$(date +%F)
  curl -LfsqO https://$host/pub/OpenBSD/snapshots/$plat/bsd.rd && \
  curl -LfsqO https://$host/pub/OpenBSD/snapshots/$plat/SHA256 && \
  curl -LfsqO https://$host/pub/OpenBSD/snapshots/$plat/SHA256.sig && \
  signify -Cp /etc/signify/$vers.pub -x SHA256.sig bsd.rd && \
  doas mv -v ./bsd.rd /bsd.rd && doas chown root:wheel /bsd.rd && \
  echo "reboot into /bsd.rd and select upgrade"
else
  exit 0
fi
