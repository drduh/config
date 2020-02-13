#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/android-update.sh
# Requires:
#   pip3 install oscrypto
#   git clone https://github.com/LineageOS/update_verifier

#set -x
set -o errtrace
set -o nounset
set -o pipefail

lineagedir="./update_verifier/"
ostypes="angler sailfish"

DUO="97:FC:DB:FF:C4:F3:0C:C3:14:1A:76:D7:17:9A:FB:42:97:4B:79:76:D6:8E:B0:AA:49:7C:12:E5:26:52:66:13"
SIGNAL="29:F3:4E:5F:27:F2:11:B4:24:BC:5B:F9:D6:71:62:C0:EA:FB:A2:DA:35:AF:35:C1:64:16:FC:44:62:76:BA:26"
FIREFOX="A7:8B:62:A5:16:5B:44:94:B2:FE:AD:9E:76:A2:80:D2:2D:93:7F:EE:62:51:AE:CE:59:94:46:B2:EA:31:9B:04"
NETGUARD="E4:A2:60:A2:DC:E7:B7:AF:23:EE:91:9C:48:9E:15:FD:01:02:B9:3F:9E:7C:9D:82:B0:9C:0B:39:50:00:E4:D4"
NEWPIPE="CB:84:06:9B:D6:81:16:BA:FA:E5:EE:4E:E5:B0:8A:56:7A:A6:D8:98:40:4E:7C:B1:2F:9E:75:6D:F5:CF:5C:AB"

fail () {
  printf "\n\n"
  tput setaf 1 1 1 ; printf "Error: ${1}\n" ; tput sgr0
  exit 1
}

grep_url() {
  grep -Eo "(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]"
}

update_pkgs() {
  printf "\n"

  # Duo
  duo_vers=$(curl -sI "https://dl.duosecurity.com/DuoMobile-latest.apk" 2>&1 | grep apk | grep -Eo '"(.*)"' | tr -d \" | head -n1)
  duo_file=$(printf ${duo_vers} | cut -d '.' -f 1-3)
  if [[ ! -f ${duo_file}.apk ]] ; then
    printf "Downloading Duo ... "
    curl -sLfO "https://dl.duosecurity.com/${duo_vers}"
  fi
  keytool -printcert -jarfile ${duo_vers} | grep -q ${DUO} || fail "could not verify Duo"
  printf "${duo_file} complete\n"

  # Signal
  signal_vers=$(curl -s "https://updates.signal.org/android/latest.json" | grep_url)
  signal_file=$(printf $(basename ${signal_vers}) | cut -d '.' -f 1-3)
  if [[ ! -f ${signal_file}.apk ]] ; then
    printf "Downloading Signal ... "
    curl -sLfO "${signal_vers}"
  fi
  keytool -printcert -jarfile ${signal_file}.apk | grep -q ${SIGNAL} || fail "could not verify Signal"
  printf "${signal_file} complete\n"

  # NetGuard
  ng_vers=$(curl -s "https://api.github.com/repos/M66B/netguard/releases/latest" | sed -n 's/.*tag_name":\s"\(.*\)".*/\1/p' | head -1)
  ng_file=$(printf "NetGuard-v${ng_vers}-release")
  if [[ ! -f ${ng_file}.apk ]] ; then
    printf "Downloading NetGuard ... "
    curl -sLfO "https://github.com/M66B/NetGuard/releases/download/${ng_vers}/NetGuard-v${ng_vers}-release.apk"
  fi
  keytool -printcert -jarfile ${ng_file}.apk | grep -q ${NETGUARD} || fail "could not verify NetGuard"
  printf "${ng_file} complete\n"

  # NewPipe
  np_vers=$(curl -s "https://api.github.com/repos/TeamNewPipe/NewPipe/releases/latest" | sed -n 's/.*tag_name":\s"\(.*\)".*/\1/p' | head -1)
  np_file=$(printf "NewPipe_${np_vers}")
  if [[ ! -f ${np_file}.apk ]] ; then
    printf "Downloading NewPipe ... "
    curl -sLfO "https://github.com/TeamNewPipe/NewPipe/releases/download/${np_vers}/NewPipe_${np_vers}.apk"
  fi
  keytool -printcert -jarfile ${np_file}.apk | grep -q ${NEWPIPE} || fail "could not verify NewPipe"
  printf "${np_file} complete\n"

  # Firefox
  ff_vers=$(curl -sI "https://download.mozilla.org/?product=fennec-latest&os=android&lang=multi" | grep_url)
  ff_file=$(basename ${ff_vers})
  if [[ ! -f ${ff_file} ]] ; then
    printf "Downloading Firefox ... "
    curl -sLfO ${ff_vers}
  fi
  keytool -printcert -jarfile ${ff_file} | grep -q ${FIREFOX} || fail "could not verify Firefox"
  printf "${ff_file} complete\n"

  # Firefox Beta
  ff_beta_vers=$(curl -sI "https://download.mozilla.org/?product=fennec-beta-latest&os=android&lang=multi" | grep_url)
  ff_beta_file=$(basename ${ff_beta_vers})
  if [[ ! -f ${ff_beta_file} ]] ; then
    printf "Downloading Firefox Beta ... "
    curl -sLfO ${ff_beta_vers}
  fi
  keytool -printcert -jarfile ${ff_beta_file} | grep -q ${FIREFOX} || fail "could not verify Firefox Beta"
  printf "${ff_beta_file} complete\n"
}

hash_pkgs() {
  sha256sum *.apk > android-pkgs.$(date +%F)
}

install_pkgs() {
  printf "\n"
  for pkg in $(awk '{print $2}' android-pkgs.$(date +%F)) ; do
    # TODO: check for existing install
    printf "  adb install -r ${pkg}\n"
  done
}

update_lineage() {
  printf "\n"

  for os in ${ostypes} ; do
    lineage_os=$(curl -s "https://download.lineageos.org/${os}" | grep ".zip" | grep_url | head -n1)
    if [[ ! -f $(basename ${lineage_os}) ]] ; then
      printf "Downloading ${lineage_os} ... "
      curl -sLfO ${lineage_os} ; fi

    if [[ ! -d ${lineagedir} ]] ; then
      echo "No Lineage update verifier" ; exit 1 ; fi

    python3 ${lineagedir}/update_verifier.py \
        ${lineagedir}/lineageos_pubkey $(basename ${lineage_os}) 2>/dev/null || fail "could not verify ${lineage_os}"

    printf "$(basename ${lineage_os}) complete\n"
  done
}

print_help() {
  printf """
  TODO"""
}

print_post_lineage_update_msg() {
  printf """
  To update:

  $ adb reboot bootloader
  $ adb sideload lineage-*.zip

  To modify system files:

  $ adb push ~/git/hosts/hosts /sdcard/Documents/
  $ adb root shell
  $ adb shell

  # mount -o rw,remount -t ext4 /system
  # mount -o rw,remount -t ext4 /
  # mv /sdcard/Documents/hosts /etc/hosts
  # exit

  $ adb unroot
  """
}

backup_sdcard() {
  adb pull "/sdcard/" ./sdcard.$(date +%F)
}


action=""
if [[ -n "${1+x}" ]] ; then
  action="${1}"
fi

while [[ -z "${action}" ]] ;
  do read -n 1 -p "
  Update [P]ackages or [O]S (or Help): " action
  printf "\n"
done

if [[ "${action}" =~ ^([hH])$ ]] ; then
  print_help
elif [[ "${action}" =~ ^([oO])$ ]] ; then
  update_lineage
  print_post_lineage_update_msg
elif [[ "${action}" =~ ^([pP])$ ]] ; then
  update_pkgs
  hash_pkgs
  install_pkgs
else
  print_help
fi

printf "\n" ; tput setaf 2 2 2 ; printf "Done\n" ; tput sgr0
