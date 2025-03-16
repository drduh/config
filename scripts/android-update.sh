#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/android-update.sh
#
# Requires:
# $ git clone https://github.com/LineageOS/update_verifier
# $ sudo apt install python3.11-venv
# $ mkdir venv ; python3 -m venv venv
# $ ./venv/bin/python ./venv/bin/pip install oscrypto
#
# Update OS:
# $ adb reboot bootloader
# $ adb sideload lineage-*.zip
#
# Update packages:
# $ adb install -r package.apk
#
# Modify system files:
# $ adb push ~/git/hosts/hosts /sdcard/Documents/
# $ adb root shell
# $ adb shell
# # mount -o rw,remount -t ext4 /system
# # mount -o rw,remount -t ext4 /
# # mv /sdcard/Documents/hosts /etc/hosts
# # exit
# $ adb unroot

#set -x  # uncomment to debug
set -o errtrace
set -o nounset
set -o pipefail

lineagedir="./update_verifier/"
ostypes="lemonadep"

AEGIS="C6:DB:80:A8:E1:4E:52:30:C1:DE:84:15:EF:82:0D:13:DC:90:1D:8F:E3:3C:F3:AC:B5:7B:68:62:D8:58:A8:23"
SIGNAL="29:F3:4E:5F:27:F2:11:B4:24:BC:5B:F9:D6:71:62:C0:EA:FB:A2:DA:35:AF:35:C1:64:16:FC:44:62:76:BA:26"
FAIREMAIL="E0:20:67:24:9F:5A:35:0E:0E:C7:03:FE:9D:F4:DD:68:2E:02:91:A0:9F:0C:2E:04:10:50:BB:E7:C0:64:F5:C9"
FIREFOX="A7:8B:62:A5:16:5B:44:94:B2:FE:AD:9E:76:A2:80:D2:2D:93:7F:EE:62:51:AE:CE:59:94:46:B2:EA:31:9B:04"
NETGUARD="E4:A2:60:A2:DC:E7:B7:AF:23:EE:91:9C:48:9E:15:FD:01:02:B9:3F:9E:7C:9D:82:B0:9C:0B:39:50:00:E4:D4"
NEWPIPE="CB:84:06:9B:D6:81:16:BA:FA:E5:EE:4E:E5:B0:8A:56:7A:A6:D8:98:40:4E:7C:B1:2F:9E:75:6D:F5:CF:5C:AB"

fail () {
  # Print an error in red and exit.

  tput setaf 1 ; printf "\nERROR: %s\n" "${1}" ; tput sgr0
  exit 1
}

grep_url() {
  grep -Eo "(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]"
}

update_pkgs() {
  printf "\n"

  # Signal
  signal_vers=$(curl -s "https://updates.signal.org/android/latest.json" | grep_url)
  signal_file="$(basename "${signal_vers}" | cut -d "." -f 1-3)"
  if [[ ! -f ${signal_file}.apk ]] ; then
    printf "Downloading Signal ... "
    curl -sLfO "${signal_vers}" || fail "could not download Signal"
  fi
  keytool -printcert -jarfile "${signal_file}.apk" | grep -q ${SIGNAL} || fail "could not verify Signal"
  printf "%s complete\n" "${signal_file}"

  # FairEmail
  fe_vers=$(curl -s "https://api.github.com/repos/M66B/FairEmail/releases/latest" | \
    sed -n 's/.*tag_name":\s"\(.*\)".*/\1/p' | head -1)
  fe_file="FairEmail-v${fe_vers}a-github-release"
  if [[ ! -f ${fe_file}.apk ]] ; then
    printf "Downloading FairEmail ... "
    set -x
    curl -sLfO "https://github.com/M66B/FairEmail/releases/download/${fe_vers}/${fe_file}.apk" || \
      fail "could not download FairEmail"
  fi
  keytool -printcert -jarfile "${fe_file}.apk" | grep -q ${FAIREMAIL} || fail "could not verify FairEmail"
  printf "%s complete\n" "${fe_file}"

  # NetGuard
  ng_vers=$(curl -s "https://api.github.com/repos/M66B/netguard/releases/latest" | \
    sed -n 's/.*tag_name":\s"\(.*\)".*/\1/p' | head -1)
  ng_file="NetGuard-v${ng_vers}-release"
  if [[ ! -f ${ng_file}.apk ]] ; then
    printf "Downloading NetGuard ... "
    curl -sLfO "https://github.com/M66B/NetGuard/releases/download/${ng_vers}/${ng_file}.apk" || \
      fail "could not download NetGuard"
  fi
  keytool -printcert -jarfile "${ng_file}.apk" | grep -q ${NETGUARD} || fail "could not verify NetGuard"
  printf "%s complete\n" "${ng_file}"

  # NewPipe
  np_vers=$(curl -s "https://api.github.com/repos/TeamNewPipe/NewPipe/releases/latest" | \
    sed -n 's/.*tag_name":\s"\(.*\)".*/\1/p' | head -1)
  np_file="NewPipe_${np_vers}"
  if [[ ! -f ${np_file}.apk ]] ; then
    printf "Downloading NewPipe ... "
    curl -sLfO "https://github.com/TeamNewPipe/NewPipe/releases/download/${np_vers}/${np_file}.apk" || \
      fail "could not download NewPipe"
  fi
  keytool -printcert -jarfile "${np_file}.apk" | grep -q ${NEWPIPE} || fail "could not verify NewPipe"
  printf "%s complete\n" "${np_file}"

  # Aegis
  aegis_vers=$(curl -s "https://api.github.com/repos/beemdevelopment/Aegis/releases/latest" | \
    sed -n 's/.*tag_name":\s"\(.*\)".*/\1/p' | head -1)
  aegis_file="aegis-${aegis_vers}"
  if [[ ! -f ${aegis_file}.apk ]] ; then
    printf "Downloading Aegis ... "
    curl -sLfO "https://github.com/beemdevelopment/Aegis/releases/download/${aegis_vers}/${aegis_file}.apk" || \
      fail "could not download aegis"
  fi
  keytool -printcert -jarfile "${aegis_file}.apk" | grep -q ${AEGIS} || fail "could not verify Aegis"
  printf "%s complete\n" "${aegis_file}"

  # Firefox
  ff_vers=$(curl -s "https://archive.mozilla.org/pub/fenix/releases/" | \
    grep -Eo "[0-9]{1,}.[0-9]{1,}.[0-9]{1,}" | sort -V | grep -v b | tail -1)
  ff_file="fenix-${ff_vers}.multi.android-arm64-v8a.apk"
  if [[ ! -f ${ff_file} ]] ; then
    printf "Downloading Firefox ... "
    curl -sLfO "https://archive.mozilla.org/pub/fenix/releases/${ff_vers}/android/fenix-${ff_vers}-android-arm64-v8a/${ff_file}" || \
      fail "could not download Firefox"
  fi
  keytool -printcert -jarfile "${ff_file}" | grep -q ${FIREFOX} || fail "could not verify Firefox"
  printf "%s complete\n" "${ff_file}"
}

update_os() {
  printf "\n"

  for os in ${ostypes} ; do
    lineage_os=$(curl -s \
      "https://download.lineageos.org/api/v2/devices/${os}/builds" | \
        sed 's/","/\n/g' | grep_url | head -1)
    los_basename="$(basename "${lineage_os}")"
    if [[ ! -f $los_basename ]] ; then
      printf "Downloading %s ..." "${lineage_os}"
      curl -sLfO "${lineage_os}" ; fi

    if [[ ! -d ${lineagedir} ]] ; then
      echo "No Lineage update verifier" ; exit 1 ; fi

    ./venv/bin/python ${lineagedir}/update_verifier.py \
        ${lineagedir}/lineageos_pubkey "$los_basename" 2>/dev/null || \
            fail "could not verify ${lineage_os}"

    printf "%s complete\n" "$los_basename"
  done
}

update_pkgs
#update_os

tput setaf 2 ; printf "\nDone\n" ; tput sgr0
