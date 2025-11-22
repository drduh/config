#!/usr/bin/env bash
# https://github.com/drduh/config/blob/main/scripts/android-update.sh
# Download and validate APK files (requires Android Studio).

#set -x  # uncomment to debug
set -o errtrace
set -o nounset
set -o pipefail

keytool="/Applications/Android Studio.app/Contents/jbr/Contents/Home/bin/keytool"
apksigner="${HOME}/Library/Android/sdk/build-tools/36.1.0/apksigner"

certAegis="C6:DB:80:A8:E1:4E:52:30:C1:DE:84:15:EF:82:0D:13:DC:90:1D:8F:E3:3C:F3:AC:B5:7B:68:62:D8:58:A8:23"
certFairEmail="E0:20:67:24:9F:5A:35:0E:0E:C7:03:FE:9D:F4:DD:68:2E:02:91:A0:9F:0C:2E:04:10:50:BB:E7:C0:64:F5:C9"
certFirefox="A7:8B:62:A5:16:5B:44:94:B2:FE:AD:9E:76:A2:80:D2:2D:93:7F:EE:62:51:AE:CE:59:94:46:B2:EA:31:9B:04"
certNetGuard="E4:A2:60:A2:DC:E7:B7:AF:23:EE:91:9C:48:9E:15:FD:01:02:B9:3F:9E:7C:9D:82:B0:9C:0B:39:50:00:E4:D4"
certNewPipe="CB:84:06:9B:D6:81:16:BA:FA:E5:EE:4E:E5:B0:8A:56:7A:A6:D8:98:40:4E:7C:B1:2F:9E:75:6D:F5:CF:5C:AB"
certSignal="29:F3:4E:5F:27:F2:11:B4:24:BC:5B:F9:D6:71:62:C0:EA:FB:A2:DA:35:AF:35:C1:64:16:FC:44:62:76:BA:26"

pkgAegis="beemdevelopment/Aegis"
pkgFairEmail="M66B/FairEmail"
pkgNetGuard="M66B/NetGuard"
pkgNewPipe="TeamNewPipe/NewPipe"

gitRepos="https://api.github.com/repos"
gitRepoAegis="${gitRepos}/${pkgAegis}"
gitRepoFairEmail="${gitRepos}/${pkgFairEmail}"
gitRepoNetGuard="${gitRepos}/${pkgNetGuard}"
gitRepoNewPipe="${gitRepos}/${pkgNewPipe}"
gitUrl="https://github.com"

urlFirefox="https://archive.mozilla.org/pub/fenix/releases/"
urlSignal="https://updates.signal.org/android/latest.json"


fail() {
  # Print error string in red and exit.
  tput setaf 1 ; printf "FAIL: %s\n" "${1}" ; tput sgr0
  exit 1
}

loading() {
  # Print loading string in blue.
  tput setaf 4 ; printf "LOAD: %s\n" "${1}" ; tput sgr0
}

latest() {
  # Print version string in yellow.
  tput setaf 3 ; printf "VERS: %s\n" "${1}" ; tput sgr0
}

pass() {
  # Print validation string in green.
  tput setaf 2 ; printf "PASS: %s\n" "${1}" ; tput sgr0
}

validate() {
  # Validate package signature with keytool and apksigner,
  # return 0 on success or exit on fail.
  "${keytool}" -printcert -jarfile "${1}" 2>/dev/null | grep -q "${2}" || \
    fail "keytool could not validate '${1}'"
  "${apksigner}" verify --verbose --print-certs "${1}" 2>/dev/null | \
    grep -q "$(printf "%s" "${2}" | \
    tr '[:upper:]' '[:lower:]' | tr -d ':')" || \
    fail "apksigner could not validate '${1}'"
}

gitRelease() {
  # Download versioned release from Github.
  loading "${3}"
  release="${gitUrl}/${1}/releases/download/${2}/${3}"
  curl --connect-timeout 5 -sLfO "${release}" || \
    fail "could not download ${1} from ${release}"
}

gitTag() {
  # Returns tag from latest release.
  curl -s "${1}/releases/latest" | jq -r '.tag_name'
}

gitPackage() {
  # Get and validate package from Github.
  latest "${1} ${3}"
  if [[ ! -f "${2}" ]] ; then
    gitRelease "${1}" "${3}" "${2}" ; fi
  validate "${2}" "${4}" && pass "${2}"
}

updateAegis() {
  version="$(gitTag ${gitRepoAegis})"
  package="aegis-${version}.apk"
  gitPackage "${pkgAegis}" "${package}" "${version}" "${certAegis}"
}

updateFairEmail() {
  version="$(gitTag ${gitRepoFairEmail})"
  package="FairEmail-v${version}a-github-release.apk"
  gitPackage "${pkgFairEmail}" "${package}" "${version}" "${certFairEmail}"
}

updateNetGuard() {
  version="$(gitTag ${gitRepoNetGuard})"
  package="NetGuard-v${version}-release.apk"
  gitPackage "${pkgNetGuard}" "${package}" "${version}" "${certNetGuard}"
}

updateNewPipe() {
  version="$(gitTag ${gitRepoNewPipe})"
  package="NewPipe_${version}.apk"
  gitPackage "${pkgNewPipe}" "${package}" "${version}" "${certNewPipe}"
}

updateFirefox() {
  version=$(curl -s "${urlFirefox}" | \
    grep -Eo "[0-9]{1,}.[0-9]{1,}.[0-9]{1,}" | sort -V | grep -v b | tail -1)
  apkPath="fenix-${version}-android-arm64-v8a"
  package="fenix-${version}.multi.android-arm64-v8a.apk"
  if [[ ! -f "${package}" ]] ; then
    loading "Firefox"
    curl -sLfO "${urlFirefox}/${version}/android/${apkPath}/${package}" || \
      fail "could not download Firefox"
  fi
  validate "${package}" "${certFirefox}" && pass "${package}"
}

updateSignal() {
  version=$(curl -s "${urlSignal}" | jq -r '.url')
  package=$(basename "${version}")
  if [[ ! -f "${package}" ]] ; then
    loading "Signal"
    curl -sLfO "${version}" || fail "could not download Signal"
  fi
  validate "${package}" "${certSignal}" && pass "${package}"
}

updateAllGit() {
  # Update packages from Git.
  updateAegis
  updateFairEmail
  updateNetGuard
  updateNewPipe
}

updateAllUrl() {
  # Update packages from Urls.
  updateFirefox
  updateSignal
}

checkConnection() {
  # Check connectivity to Git or exit.
  curl -sI "${gitUrl}" >/dev/null || \
    fail "could not reach '${gitUrl}'"
}

main() {
  # Main function.
  checkConnection
  updateAllGit
  updateAllUrl
}

main
