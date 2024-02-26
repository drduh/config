# https://github.com/drduh/config/blob/master/zshrc
umask 077
autoload -U colors && colors
autoload -U compinit && compinit

bindkey "^[[1;5C" vi-forward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;5D" vi-backward-word
bindkey "^[[1;3D" backward-word

PS1="%{$fg[red]%}%h %{$fg[yellow]%}%~ %{$reset_color%}% "
SPROMPT="$fg[red]%R$reset_color did you mean $fg[green]%r?$reset_color "
NOW="$(date +%F-%H:%M:%S)"
TODAY="$(date +%F)"
TS="$(date +%s)"
NETWORK="$(/sbin/ifconfig | grep UP | grep -v LOOPBACK | awk -F: '{print $1}')"
ROOT="$(command -v sudo || command -v doas)"
SERVER="http://192.168.1.1"
DOWNLOAD="${SERVER}/upload/"
UPLOAD="${SERVER}/cgi-bin/upload.py"
HISTFILE="${HOME}/.histfile"
HISTSIZE=200
SAVEHIST=${HISTSIZE}

LANG="en_US.UTF-8"
export LC_ADDRESS=${LANG}
export LC_ALL=${LANG}
export LC_COLLATE=${LANG}
export LC_CTYPE=${LANG}
export LC_IDENTIFICATION=${LANG}
export LC_MEASUREMENT=${LANG}
export LC_MESSAGES=${LANG}
export LC_MONETARY=${LANG}
export LC_NAME=${LANG}
export LC_PAPER=${LANG}
export LC_TELEPHONE=${LANG}
export LC_TIME=${LANG}

export LESS="-FRX"
export LESSCHARSET="utf-8"
export LESSHISTFILE=-
export LESSSECURE=1
export PYTHONSTARTUP="${HOME}/.pythonrc"

export GOPATH="${HOME}/go"
export GOBIN="${HOME}/go/bin"

#export http_proxy="127.0.0.1:8118"
#export https_proxy="127.0.0.1:8118"

setopt alwaystoend
setopt autocd
setopt autopushd
setopt completeinword
setopt correct
setopt extendedglob
setopt extendedhistory
setopt histignorealldups
setopt histignorespace
setopt histreduceblanks
setopt listtypes
setopt nobeep
setopt nocaseglob
setopt noclobber
setopt nullglob

zstyle ":completion:*" auto-description "specify %d"
zstyle ":completion:*" cache-path "${HOME}/.zsh_cache"
zstyle ":completion:*" completer _expand _complete _correct _approximate
zstyle ":completion:*" file-sort modification reverse
zstyle ":completion:*" format "completing %d"
zstyle ":completion:*" group-name ""
zstyle ":completion:*" hosts off
zstyle ":completion:*" list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ":completion:*" menu select=long-list select=0
zstyle ":completion:*" use-cache on
zstyle ":completion:*" verbose yes
zstyle ":completion:*:kill:*" command "ps -u ${USER} -o pid,%cpu,tty,cputime,cmd"

alias -g G="| grep -i"
alias -g H="| head"
alias -g L="| less"
alias -g S="| sort"
alias -g T="| tail"
alias -g U="| uniq"
alias -g V="| vim -"
alias -g XC="| xclip -i"
alias -g XP="| xclip -o"
alias l="ls -ltrhsa"
alias ls="ls -lha"
alias lo="libreoffice"
alias t="tail -f"
alias v="vim -p"
alias cat="cat -t"
alias cp="cp -i"
alias md="mkdir -p"
alias mv="mv -i"
alias p="python3"
alias ping1="ping -4 -c3 -i.5 -v 1.1.1.1"
alias ping8="ping -4 -c3 -i.5 -v 8.8.8.8"
alias rm="rm -i"
alias audio="pgrep pulseaudio||pulseaudio &;pacmd list-sinks|egrep '\*|card:'"
alias audio_set="pacmd set-default-sink ${1}"
alias bios="${ROOT} dmidecode -s bios-version"
alias cr="firejail --dbus-user=none chromium --enable-unveil --incognito --no-referrers --no-pings --no-experiments --disable-translate --dns-prefetch-disable --disable-background-mode --no-first-run --no-default-browser-check --ssl-version-min=tls1.2"
alias dif="diff"
alias feh="feh --auto-rotate --auto-zoom --draw-filename --recursive --scale-down --verbose"
alias ff="firefox --ProfileManager --no-remote"
alias ftb="firejail --profile=firejailed-tor-browser ${HOME}/Browser/start-tor-browser"
alias gitadd="git add"
alias gitcommit="git commit"
alias gitdiff="git diff"
alias gitpull="git pull"
alias gitpush="git push"
alias gitstatus="git status"
alias gp="for r in */.git ; do ( cd \$r/.. && git pull ; ) ; done"
alias grep="grep --color --text"
alias grepv="grep --invert-match"
alias mnt="${ROOT} mount -o uid=1000 ${1}"
alias rebootfw="systemctl reboot --firmware-setup"
alias resize_view="xrandr --output Virtual1 --mode 1600x1200"
alias tb="thunderbird --ProfileManager --no-remote"
alias td="mkdir ${TODAY} ; cd ${TODAY}"
alias vm="virt-manager"
alias wifich="iwlist ${NETWORK} channel | grep Current | awk -F: '{print \$2}'"
alias x="startx"
alias yt="youtube-dl --restrict-filenames --no-overwrites --write-info-json --write-thumbnail --no-call-home --force-ipv4 --format 'best[height<=720]'"
alias yt_max="youtube-dl --restrict-filenames --no-overwrites --write-info-json --write-thumbnail --no-call-home --force-ipv4"

alias x230_read_bot="flashrom -c 'MX25L6406E/MX25L6408E' -p linux_spi:dev=/dev/spidev0.0,spispeed=512 -r bottom.rom.${TODAY}"
alias x230_read_top="flashrom -c 'MX25L3206E/MX25L3208E' -p linux_spi:dev=/dev/spidev0.0,spispeed=512 -r top.rom.${TODAY}"
alias x230_write_bot="flashrom -c 'MX25L6406E/MX25L6408E' -p linux_spi:dev=/dev/spidev0.0,spispeed=512 -w coreboot-bottom.rom"
alias x230_write_top="flashrom -c 'MX25L3206E/MX25L3208E' -p linux_spi:dev=/dev/spidev0.0,spispeed=512 -w coreboot-top.rom"

alias bw-firefox="""
bwrap \
--symlink usr/lib /lib \
--symlink usr/lib64 /lib64 \
--symlink usr/bin /bin \
--symlink usr/bin /sbin \
--ro-bind /usr/lib /usr/lib \
--ro-bind /usr/lib64 /usr/lib64 \
--ro-bind /usr/bin /usr/bin \
--ro-bind /usr/share/applications /usr/share/applications \
--ro-bind /usr/share/fontconfig /usr/share/fontconfig \
--ro-bind /usr/share/drirc.d /usr/share/drirc.d \
--ro-bind /usr/share/fonts /usr/share/fonts \
--ro-bind /usr/share/glib-2.0 /usr/share/glib-2.0 \
--ro-bind /usr/share/glvnd /usr/share/glvnd \
--ro-bind /usr/share/icons /usr/share/icons \
--ro-bind /usr/share/libdrm /usr/share/libdrm \
--ro-bind /usr/share/mime /usr/share/mime \
--ro-bind /usr/share/X11/xkb /usr/share/X11/xkb \
--ro-bind /usr/share/icons /usr/share/icons \
--ro-bind /usr/share/mime /usr/share/mime \
--ro-bind /etc/fonts /etc/fonts \
--ro-bind /usr/share/ca-certificates /usr/share/ca-certificates \
--ro-bind /etc/ssl /etc/ssl \
--ro-bind /etc/ca-certificates /etc/ca-certificates \
--dir /run/user/"$(id -u)" \
--ro-bind /run/user/"$(id -u)"/pulse /run/user/"$(id -u)"/pulse \
--dev /dev \
--dev-bind /dev/dri /dev/dri \
--ro-bind /sys/dev/char /sys/dev/char \
--ro-bind /sys/devices/pci0000:00 /sys/devices/pci0000:00 \
--proc /proc \
--tmpfs /tmp \
--bind-try ~/.mozilla ~/.mozilla \
--bind-try ~/Downloads ~/Downloads \
--bind-try ~/.cache/mozilla ~/.cache/mozilla \
--setenv PATH /usr/bin \
--hostname RESTRICTED \
--unshare-all \
--share-net \
--die-with-parent \
--new-session \
/usr/bin/firefox"""  # remove pulse bind to disable audio

function .. { cd ".." ; }
function ... { cd "../.." ; }
function .... { cd "../../.." ; }

function dedupe {
  find "${@}" ! -empty -type f -exec md5sum {} + | \
    sort | uniq -w32 -dD }

function domain () {  # truncate to top level domain
  awk -F "." '{print ( $(NF-1)"."$(NF) )}' "${1}" }

function gpg_restart {
  pkill gpg
  pkill pinentry
  pkill ssh-agent
  eval $(gpg-agent --daemon --enable-ssh-support) }

function lock {
  date
  xhost &>/dev/null || return
  (sleep 1 ; slock) 2>/dev/null &
  sleep 1 ; systemctl suspend }

function grep_ip {
  grep -Eo \
    "([0-9]{1,3}\.){3}[0-9]{1,3}" "${@}" }

function grep_url {
  grep -Eo \
    "(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]" "${@}" }

function adbpkg {
  for p in $(adb shell pm list package|awk -F "package:" '{print $2}'); \
    do echo -n "$p: "
      adb shell dumpsys package $p | \
        grep -i versionname | \
          awk -F "=" '{print $2}'
  done > adb.pkg.$(date +%F) }

function backup () {
  cp -v "${1}" "${1}.${TS}" }

function bat {
  upower -i /org/freedesktop/UPower/devices/battery_BAT0 | \
    grep -E "state|to\ full|percentage" || apm }

function calc {
  awk "BEGIN { print "$*" }" }

function cert {
  cn="${1:-${TS}}"
  expire="${2:-8}"
  openssl req -new \
    -newkey rsa:4096 -nodes \
    -subj "/CN=${cn}" \
    -x509 -sha512 -days "${expire}" \
    -keyout "s.${cn}.pem" -out "s.${cn}.crt"
  openssl x509 -in "s.${cn}.crt" -noout \
    -subject -issuer -dates -serial
  for ft in \-sha1 \-sha256 \-sha512 ; do \
    openssl x509 -in "s.${cn}.crt" -noout \
    -fingerprint ${ft} | tr -d ":" ; done }

function cidr {
  whois -h "whois.arin.net" -- \
  "n + $(curl -s https://icanhazip.com/)" | \
    grep "CIDR:" }

function colours {
  for i in {001..255} ; do \
    printf "\x1b[38;5;${i}m${i}\n" | \
    tr "\n" " " ; done | fold -w 255 }

function convert_secs {
  ((h=${1}/3600)) ; ((m=(${1}%3600)/60)) ; ((s=${1}%60))
  printf "%02d:%02d:%02d\n" ${h} ${m} ${s} }

function dump_arp {
  ${ROOT} tcpdump -eni ${NETWORK} -w arp-${NOW}.pcap \
    "ether proto 0x0806" }

function dump_icmp {
  ${ROOT} tcpdump -ni ${NETWORK} -w icmp-${NOW}.pcap \
    "icmp" }

function dump_pflog {
  ${ROOT} tcpdump -ni pflog0 -w pflog-${NOW}.pcap \
    "not icmp6 and not host ff02::16 and not host ff02::d" }

function dump_syn {
  ${ROOT} tcpdump -ni ${NETWORK} -w syn-${NOW}.pcap \
    "tcp[13] & 2 != 0" }

function dump_udp {
  ${ROOT} tcpdump -ni ${NETWORK} -w udp-${NOW}.pcap \
    "udp and not port 443" }

function dump_dns {
  tshark -i ${NETWORK} -Y "dns.flags.response == 1" -Tfields \
    -e frame.time_delta -e dns.qry.name -e dns.a -Eseparator=, }

function dump_http {
  tshark -i ${NETWORK} -Y "http.request or http.response" -Tfields \
    -e ip.dst -e http.request.full_uri -e http.request.method \
      -e http.response.code -e http.response.phrase -Eseparator=, }

function dump_ssl {
  tshark -i ${NETWORK} -Y "ssl.handshake.certificate" -Tfields \
    -e ip.src -e x509sat.uTF8String -e x509sat.printableString \
      -e x509sat.universalString -e x509sat.IA5String \
        -e x509sat.teletexString -Eseparator=, }

function e {  # appx bits of entropy: e <chars> <length>
  awk -v c=${1} -v l=${2} "BEGIN { print log(c^l)/log(2) }" }

function f {
  find . -iname "*${1}*" }

function fd {
  find . -iname "*${1}*" -type d }

function gas {  # get CIDRs for AS number
  whois -h whois.radb.net '!g'${1} }

function myip {
  curl -s "https://icanhazip.com/" || \
    dig @resolver1.opendns.com ANY myip.opendns.com +short }

function pdf {
  mupdf -r 180 -C FDF6E3 "${1}" }

function png2jpg {
  for png in $(find . -type f -name "*.png") ; do
    image="${png%.*}"
    convert "${image}.png" "${image}.jpg" ; done }

function nonlocal () {
  egrep -ve "^#|^255.255.255.255|^127.|^0.|^::1|^ff..::|^fe80::" "${1}" | \
    egrep -e "[1,2]|::"
}

function nxdomains {
  for x in $(${ROOT} grep NXDOMAIN /var/log/dnsmasq | \
    awk '{print $6}' | sort | uniq) ; do printf "0.0.0.0 $x\n" ; done
}

function rand {
  for item in \
    '[:digit:]' '[:upper:]' \
    '[:xdigit:]' '[:alnum:]' '[:graph:]' ; do \
      tr -dc "${item}" < /dev/urandom | \
      fold -w 64 | head -n 3 | \
      sed "-es/./ /"{1..64..16} ; done }

function rand_mac {
  openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.$//" }

function rand_pass {
  LC_ALL=C tr -dc 'A-Z1-9' < /dev/urandom | \
    tr -d "1IOS5U" | fold -w 30 | head -n10 | \
    sed "-es/./ /"{1..26..5} | cut -c2- | tr " " "-" }

function resize_ff {
  xdotool windowsize \
    $(xdotool search --name firefox | tail -n1) 1366 768 }

function reveal {
  output=$(echo "${1}" | rev | cut -c16- | rev)
  gpg --decrypt --output ${output} "${1}" \
    && echo "${1} -> ${output}" }

function rs {
  rsync --verbose --archive --human-readable \
    --progress --stats --ipv4 --compress \
    --log-file=$(mktemp) "${@}" }

function secret {  # preferred id last
  output="${HOME}/$(basename ${1}).$(date +%F).enc"
  gpg --encrypt --armor \
    --output ${output} \
    -r 0xFF00000000000000 \
    -r yubikey@example \
    "${1}" && echo "${1} -> ${output}" }

function sort_ip {
  sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n "${@}" }

function srl {
  doas cu -r -s 115200 -l cuaU0 2>/dev/null || \
    sudo minicom -D /dev/ttyUSB0 2>/dev/null || \
      printf "serial console disconnected\n" }

function top_history {
  history 1 | awk '{CMD[$2]++;count++;}END {
    for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | \
      column -c3 -s " " -t | sort -nr | nl |  head -n25 }

function download () {
  curl -O ${DOWNLOAD}/"${@}" }

function upload {
   curl -s -F "file=@${@}" ${UPLOAD} | \
     grep -q "Saved" && printf "Uploaded ${@}\n" }

function vpn {
  ssh -C -N -L 5555:127.0.0.1:8118 vpn }

function zshaddhistory {
  whence "${${(z)1}[1]}" >| /dev/null || return 1
  local line cmd
  line=${1%%$'\n'}
  cmd=${line%% *}
  [[ ${#line} -ge 5 \
    && ${cmd} != (apm|apt-cache|base64|bzip2|cal|calc|cat|cd|chmod|convert|cp|curl|cvs|date|df|dig|disklabel|dmesg|doas|download|du|e|egrep|enc|ent|exiftool|f|fdisk|feh|ffplay|file|find|firejail|gimp|git|gpg|grep|hdiutil|head|hostname|ifconfig|kill|less|libreoffice|lp|ls|mail|make|man|mkdir|mnt|mount|mpv|mv|nc|openssl|patch|pdf|pdfinfo|pgrep|ping|pkg_info|pkill|ps|pylint|rcctl|rm|rsync|scp|scrot|set|sha256|secret|sort|srm|ssh|ssh-keygen|startx|stat|strip|sudo|sysctl|tar|tmux|top|umount|uname|unzip|upload|uptime|useradd|vlc|vi|vim|wc|wget|which|whoami|whois|wireshark|xclip|xxd|youtube-dl|ykman|yt|./pwd.sh|./purse.sh)
  ]]
}

function zzz {
  /usr/sbin/zzz 2>/dev/null || \
    systemctl suspend }

function path {
  if [[ -d "${1}" ]] ; then
    if [[ -z "${PATH}" ]] ; then
      export PATH="${1}"
    else
      export PATH="${PATH}:${1}"
    fi
  fi
}

export PATH=""
path "/usr/local/sbin"
path "/usr/local/bin"
path "/usr/sbin"
path "/usr/bin"
path "/sbin"
path "/bin"
#path "/usr/games"
#path "/usr/X11R6/bin"
#path "${HOME}/go/bin"

#alias gpg="gpg2"
#alias sha256="sha256sum"
#alias sha512="sha512sum"
#export HOMEBREW_CASK_OPTS=--require-sha
#export HOMEBREW_NO_ANALYTICS=1
#export HOMEBREW_NO_AUTO_UPDATE=1
#export HOMEBREW_NO_INSECURE_REDIRECT=1
#export GPG_TTY="$(tty)"
#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#gpgconf --launch gpg-agent
#gpg-connect-agent updatestartuptty /bye >/dev/null
