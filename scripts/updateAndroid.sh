#!/usr/bin/env bash
# https://github.com/drduh/config/blob/main/scripts/updateAndroid.sh
# Download and verify APK files (requires Android Studio).

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
certProton="DC:C9:43:9E:C1:A6:C6:A8:D0:20:3F:34:23:EE:42:BC:C8:B9:70:62:8E:53:CB:73:A0:39:3F:39:8D:D5:B8:53"
certSignal="29:F3:4E:5F:27:F2:11:B4:24:BC:5B:F9:D6:71:62:C0:EA:FB:A2:DA:35:AF:35:C1:64:16:FC:44:62:76:BA:26"

pkgAegis="beemdevelopment/Aegis"
pkgFairEmail="M66B/FairEmail"
pkgNetGuard="M66B/NetGuard"
pkgProton="ProtonMail/android-mail"
pkgNewPipe="TeamNewPipe/NewPipe"

gitRepos="https://api.github.com/repos"
gitRepoAegis="${gitRepos}/${pkgAegis}"
gitRepoFairEmail="${gitRepos}/${pkgFairEmail}"
gitRepoNetGuard="${gitRepos}/${pkgNetGuard}"
gitRepoNewPipe="${gitRepos}/${pkgNewPipe}"
gitRepoProton="${gitRepos}/${pkgProton}"
gitUrl="https://github.com"

urlFirefox="https://archive.mozilla.org/pub/fenix/releases"
urlSignal="https://updates.signal.org/android/latest.json"


fail() {
  # Print error string in red and exit.
  tput setaf 1 ; printf "FAIL: %s\n" "${1}" ; tput sgr0
  exit 1
}

printLoad() {
  # Print loading string in blue.
  tput setaf 4 ; printf "LOAD: %s\n" "${1}" ; tput sgr0
}

printRelease() {
  # Print release string in yellow.
  tput setaf 3 ; printf "VERS: %s\n" "${1}" ; tput sgr0
}

printValid() {
  # Print validation string in green.
  tput setaf 2 ; printf "PASS: %s\n" "${1}" ; tput sgr0
}

download() {
  # Download and save file, or exit on error.
  curl --connect-timeout 5 -sLfO "${1}" || \
    fail "could not download '${1}'"
}

verify() {
  # Verify signature with keytool and apksigner,
  # return 0 on success or exit on fail.
  "${keytool}" -printcert -jarfile "${1}" 2>/dev/null | grep -q "${2}" || \
    fail "keytool could not verify '${1}'"
  "${apksigner}" verify --verbose --print-certs "${1}" 2>/dev/null | \
    grep -q "$(printf "%s" "${2}" | \
    tr '[:upper:]' '[:lower:]' | tr -d ':')" || \
    fail "apksigner could not verify '${1}'"
}

getReleaseGit() {
  # Get and parse latest Git release information.
  json=$(curl -s "${1}/releases/latest") || \
    fail "could not get release"
  if ! jq -e '.assets | length > 0' >/dev/null <<< "${json}" ; then
    fail "no release found" ; fi
  jq -r '.assets[0] |
    [.uploader.login, .name, .browser_download_url,
    (.download_count|tostring), .updated_at] | @tsv' <<< "${json}"
}

getPackageGit() {
  # Download and verify latest Git release package.
  IFS=$'\t' read -r \
    author package url count mtime < <(getReleaseGit "${1}")
  printRelease "${package} (${author}@${mtime}, ${count} downloads)"
  if [[ ! -f "${package}" ]] ; then
		printLoad "${package}" ; download "${url}" ; fi
  verify "${package}" "${2}" && printValid "${package}"
}

updateAegis() {
  getPackageGit "${gitRepoAegis}" "${certAegis}"
}

updateFairEmail() {
  getPackageGit "${gitRepoFairEmail}" "${certFairEmail}"
}

updateNetGuard() {
  getPackageGit "${gitRepoNetGuard}" "${certNetGuard}"
}

updateNewPipe() {
  getPackageGit "${gitRepoNewPipe}" "${certNewPipe}"
}

updateProton() {
  getPackageGit "${gitRepoProton}" "${certProton}"
}

updateFirefox() {
  version=$(curl -s "${urlFirefox}/" | \
    grep -Eo "[0-9]{1,}.[0-9]{1,}.[0-9]{1,}" | sort -V | grep -v b | tail -1)
  apkPath="fenix-${version}-android-arm64-v8a"
  package="fenix-${version}.multi.android-arm64-v8a.apk"
  if [[ ! -f "${package}" ]] ; then
    printLoad "${package}"
    curl -sLfO "${urlFirefox}/${version}/android/${apkPath}/${package}" || \
      fail "could not download Firefox"
  fi
  verify "${package}" "${certFirefox}" && printValid "${package}"
}

updateSignal() {
  version=$(curl -s "${urlSignal}" | jq -r '.url')
  package=$(basename "${version}")
  if [[ ! -f "${package}" ]] ; then
    printLoad "Signal"
    curl -sLfO "${version}" || fail "could not download Signal"
  fi
  verify "${package}" "${certSignal}" && printValid "${package}"
}

updateAllGit() {
  # Update packages from Git.
  updateAegis
  updateFairEmail
  updateNetGuard
  updateNewPipe
  updateProton
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
