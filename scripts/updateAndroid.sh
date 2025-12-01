#!/usr/bin/env bash
# https://github.com/drduh/config/blob/main/scripts/updateAndroid.sh
# Download and verify APK files (requires Android Studio).

#set -x  # uncomment to debug
set -o errtrace
set -o nounset
set -o pipefail

apksigner="$(command -v apksigner || command -v \
  ${HOME}/Library/Android/sdk/build-tools/36.1.0/apksigner)"

certAegis="c6db80a8e14e5230c1de8415ef820d13dc901d8fe33cf3acb57b6862d858a823"
certFairEmail="e02067249f5a350e0ec703fe9df4dd682e0291a09f0c2e041050bbe7c064f5c9"
certFirefox="a78b62a5165b4494b2fead9e76a280d22d937fee6251aece599446b2ea319b04"
certFossify="affdb124d3f4720c2f98dbca9eacba0514fba4306e20a2786c861c3c0d6ff292"
certKiwix="6dfbfc62e16587a78aa2d9585ae9bb7f6973c2bf84034b7b90101a401409f5aa"
certNetGuard="e4a260a2dce7b7af23ee919c489e15fd0102b93f9e7c9d82b09c0b395000e4d4"
certNewPipe="cb84069bd68116bafae5ee4ee5b08a567aa6d898404e7cb12f9e756df5cf5cab"
certOsmand="d192f4fffff2fae37f2821e4ca44f4cbe2483e7ffa24a8472043f685dd5bed27"
certProton="dcc9439ec1a6c6a8d0203f3423ee42bcc8b970628e53cb73a0393f398dd5b853"
certSignal="4be4f6cd5be844083e900279dc822af65a547fecc26aba7ff1f5203a45518cd8"

gitRepos="https://api.github.com/repos"
gitRepoAegis="${gitRepos}/beemdevelopment/Aegis"
gitRepoCalendar="${gitRepos}/FossifyOrg/Calendar"
gitRepoFairEmail="${gitRepos}/M66B/FairEmail"
gitRepoGallery="${gitRepos}/FossifyOrg/Gallery"
gitRepoKiwix="${gitRepos}/kiwix/kiwix-android"
gitRepoNetGuard="${gitRepos}/M66B/NetGuard"
gitRepoNewPipe="${gitRepos}/TeamNewPipe/NewPipe"
gitRepoProton="${gitRepos}/ProtonMail/android-mail"
gitUrl="https://github.com"

urlFirefox="https://archive.mozilla.org/pub/fenix/releases"
urlOsmand="https://download.osmand.net/releases"
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
  # Verify signature with apksigner or exit on fail.
  "${apksigner}" verify --verbose --print-certs "${1}" 2>/dev/null | \
    grep -q "${2}" || fail "could not verify '${1}'"
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

updateCalendar() {
  getPackageGit "${gitRepoCalendar}" "${certFossify}"
}

updateFairEmail() {
  getPackageGit "${gitRepoFairEmail}" "${certFairEmail}"
}

updateGallery() {
  getPackageGit "${gitRepoGallery}" "${certFossify}"
}

updateKiwix() {
  getPackageGit "${gitRepoKiwix}" "${certKiwix}"
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
    grep -Eo "[0-9]{1,}.[0-9]{1,}.[0-9]{1,}" | grep -v b | sort -V | tail -1)
  apkPath="fenix-${version}-android-arm64-v8a"
  package="fenix-${version}.multi.android-arm64-v8a.apk"
  if [[ ! -f "${package}" ]] ; then
    printLoad "${package}"
    curl -sLfO "${urlFirefox}/${version}/android/${apkPath}/${package}" || \
      fail "could not download Firefox"
  fi
  verify "${package}" "${certFirefox}" && printValid "${package}"
}

updateOsmand() {
  package=$(curl -s "${urlOsmand}/" | \
    grep -Eo "net.osmand-[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}.apk" | \
      sort -V | tail -1)
  if [[ ! -f "${package}" ]] ; then
    printLoad "${package}"
    curl -sLfO "${urlOsmand}/${package}" || \
      fail "could not download '${package}'"
  fi
  verify "${package}" "${certOsmand}" && printValid "${package}"
}

updateSignal() {
  version=$(curl -s "${urlSignal}" | jq -r '.url')
  package=$(basename "${version}")
  if [[ ! -f "${package}" ]] ; then
    printLoad "${package}"
    curl -sLfO "${version}" || \
      fail "could not download '${package}'"
  fi
  verify "${package}" "${certSignal}" && printValid "${package}"
}

updateAllGit() {
  # Update packages from Git.
  updateAegis
  updateCalendar
  updateFairEmail
  updateGallery
  updateKiwix
  updateNetGuard
  updateNewPipe
  updateProton
}

updateAllUrl() {
  # Update packages from Urls.
  updateFirefox
  updateOsmand
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
