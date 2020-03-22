# https://github.com/drduh/config/blob/master/zshrc
umask 077
autoload -U colors && colors
autoload -U compinit && compinit

HISTFILE=~/.histfile
HISTSIZE=200
SAVEHIST=${HISTSIZE}
LANG=en_US.UTF-8
export LC_ALL=C
export LC_CTYPE=${LC_ALL}
PS1="%{$fg[red]%}%h %{$fg[yellow]%}%~ %{$reset_color%}% "
SPROMPT="$fg[red]%R$reset_color did you mean $fg[green]%r?$reset_color "
NETWORK="$(/sbin/ifconfig | head -n1 | awk -F: '{print $1}')"
ROOT="$(command -v sudo || command -v doas)"
UPLOAD="http://192.168.1.1/cgi-bin/upload.cgi"

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
zstyle ":completion:*" cache-path ~/.zsh_cache
zstyle ":completion:*" completer _expand _complete _correct _approximate
zstyle ":completion:*" file-sort modification reverse
zstyle ":completion:*" format "completing %d"
zstyle ":completion:*" group-name ""
zstyle ":completion:*" hosts off
zstyle ":completion:*" list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ":completion:*" menu select=long-list select=0
zstyle ":completion:*" use-cache on
zstyle ":completion:*" verbose yes

alias -g H="| head"
alias -g L="| less"
alias -g S="| sort"
alias -g T="| tail"
alias -g XC="| xclip -i"
alias -g XP="| xclip -o"
alias l="ls -ltrhsa"
alias ls="ls -lha"
alias t="tail -f"
alias v="vim -p"
alias md="mkdir -p"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias audio="pgrep pulseaudio||pulseaudio &;pacmd list-sinks|egrep '\*|card:'"
alias audio_set="pacmd set-default-sink ${1}"
alias ea="cat /proc/sys/kernel/random/entropy_avail"
alias cr="chrome --enable-unveil --incognito --ssl-version-min=tls1.2 --cipher-suite-blacklist=0x009c,0x009d,0x002f,0x0035,0x000a,0xc013,0xc014"
alias ff="firefox --ProfileManager --no-remote"
alias tb="thunderbird --ProfileManager --no-remote"
alias feh="feh --auto-rotate --draw-filename --recursive --scale-down --verbose"
alias yt="youtube-dl --restrict-filenames --no-overwrites --write-info-json --no-call-home --force-ipv4 --format 'best[height<=720]'"
alias today="date +%F"
alias now="date +%F-%H:%M:%S"

function .. { cd ".." ; }
function ... { cd "../.." ; }
function .... { cd "../../.." ; }

function dedupe {
  find "${@}" ! -empty -type f -exec md5sum {} + | \
    sort | uniq -w32 -dD
}

function domain () {
  awk -F "." '{print ( $(NF-1)"."$(NF) )}' "${1}" }

function gpg_restart {
  pkill gpg
  pkill pinentry
  pkill ssh-agent
  eval $(gpg-agent --daemon --enable-ssh-support) }

function lock {
  date
  (sleep 1 ; slock) &
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

function bat {
  upower -i /org/freedesktop/UPower/devices/battery_BAT0 | \
    grep -E "state|to\ full|percentage" }

function calc {
  awk "BEGIN { print "$*" }" }

function cert {
  openssl req -new -newkey rsa:4096 \
    -subj "/CN=$(date +%s)" \
      -sha512 -days 8 -nodes -x509 \
        -keyout s.pem -out s.crt
  openssl x509 -in s.crt -noout \
    -subject -issuer -dates -fingerprint }

function cidr {
  whois -h "whois.arin.net" -- \
    "n + $(curl -s https://icanhazip.com/)" | \
      grep "CIDR:" }

function colours {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i}\n" ; done }

function convert_secs {
  ((h=${1}/3600)) ; ((m=(${1}%3600)/60)) ; ((s=${1}%60))
  printf "%02d:%02d:%02d\n" ${h} ${m} ${s} }

function dump_arp {
  ${ROOT} tcpdump -eni ${NETWORK} -w arp-$(now).pcap \
    "ether proto 0x0806" }

function dump_icmp {
  ${ROOT} tcpdump -ni ${NETWORK} -w icmp-$(now).pcap \
    "icmp" }

function dump_pflog {
  ${ROOT} tcpdump -ni pflog0 -w pflog-$(now).pcap \
    "not icmp6 and not host ff02::16 and not host ff02::d" }

function dump_syn {
  ${ROOT} tcpdump -ni ${NETWORK} -w syn-$(now).pcap \
    "tcp[13] & 2 != 0" }

function dump_udp {
  ${ROOT} tcpdump -ni ${NETWORK} -w udp-$(now).pcap \
    "udp and not port 443" }

function dump_dns {
  tshark -Y "dns.flags.response == 1" -Tfields \
    -e frame.time_delta -e dns.qry.name -e dns.a \
      -Eseparator=, }

function dump_http {
  tshark -Y "http.request or http.response" -Tfields \
    -e ip.dst -e http.request.full_uri -e http.request.method \
      -e http.response.code -e http.response.phrase \
        -Eseparator=, }

function dump_ssl {
  tshark -Y "ssl.handshake.certificate" -Tfields \
    -e ip.src -e x509sat.uTF8String -e x509sat.printableString \
      -e x509sat.universalString -e x509sat.IA5String \
        -e x509sat.teletexString \
          -Eseparator=, }

function e {
  awk -v c=${1} -v l=${2} "BEGIN { print log(c^l) }" }

function f {
  find . -iname "*${1}*" }

function fd {
  find . -iname "*${1}*" -type d }

function gas {
  whois -h whois.radb.net '!g'${1} }

function myip {
  curl -sq "https://icanhazip.com/" }

function pdf {
  mupdf -r 180 -C FDF6E3 "${1}" }

function png2jpg {
  for png in $(find . -type f -name "*.png") ; do
    image=${png%.*}
    convert "${image}.png" "${image}.jpg" ; done }

function nonlocal () {
  egrep -ve "^#|^255.255.255.255|^127.|^0.|^::1|^ff..::|^fe80::" "${1}" | \
    egrep -e "[1,2]|::"
}

function rand {
  for item in '01' \
    '[:digit:]' '[:upper:]' \
    '[:xdigit:]' '[:alnum:]' '[:graph:]' ; do \
      tr -dc "${item}" < /dev/urandom | \
        fold -w 40 | head -n 5 | \
          sed "-es/./ /"{1..40..10} ; done }

function rand_mac {
  openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.$//" }

function resize_ff {
  xdotool windowsize $(xdotool search --name firefox | tail -n1) \
    1366 768 }

function reveal {
  output=$(echo "${1}" | rev | cut -c16- | rev)
  gpg --decrypt --output ${output} "${1}" \
    && echo "${1} -> ${output}" }

function rs {
  rsync --verbose --archive --human-readable \
    --progress --stats --ipv4 --compress \
    --log-file=$(mktemp) "${@}" }

function secret {
  output=~/"${1}".$(date +%s).enc
  gpg --encrypt --armor \
    --output ${output} \
    -r 0xFF3E7D88647EBCDB \
    -r github@duh.to \
    "${1}" && echo "${1} -> ${output}" }

function srl {
  doas cu -r -s 115200 -l cuaU0 2>/dev/null || \
    sudo minicom -D /dev/ttyUSB0 2>/dev/null || \
      printf "disconnected\n" }

function top_history {
  history 1 | awk '{CMD[$2]++;count++;}END {
    for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | \
      column -c3 -s " " -t | sort -nr | nl |  head -n25 }

function upload {
  curl --http1.0 -F "file=@${@}" ${UPLOAD} }

function vpn {
  ssh -C -N -L 5555:127.0.0.1:8118 vpn }

function zshaddhistory {
  whence "${${(z)1}[1]}" >| /dev/null || return 1
  local line cmd
  line=${1%%$'\n'}
  cmd=${line%% *}
  [[ ${#line} -ge 5 \
    && ${cmd} != (apm|base64|bzip2|cal|calc|cat|cd|chmod|cp|curl|cvs|date|df|dig|disklabel|dmesg|doas|du|e|egrep|enc|ent|exiftool|f|fdisk|feh|file|find|gimp|git|gpg|grep|hdiutil|head|hostname|ifconfig|kill|less|ls|mail|make|man|mkdir|mount|mpv|mv|nc|openssl|patch|pdf|pdfinfo|pgrep|ping|pkg_info|pkill|ps|rcctl|rm|rsync|scp|scrot|set|sha256|secret|sort|srm|ssh|ssh-keygen|stat|strip|sudo|sysctl|tar|tmux|top|umount|uname|unzip|upload|uptime|useradd|vlc|vi|vim|wc|wget|which|whoami|whois|wireshark|xclip|xxd|youtube-dl|yt|./pwd.sh|./purse.sh)
  ]]
}

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
#path "~/go/bin"

#export HOMEBREW_CASK_OPTS=--require-sha
#export HOMEBREW_NO_ANALYTICS=1
#export HOMEBREW_NO_AUTO_UPDATE=1
#export HOMEBREW_NO_INSECURE_REDIRECT=1
#export GOPATH=~/go
#export GPG_TTY="$(tty)"
#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#gpgconf --launch gpg-agent
#gpg-connect-agent updatestartuptty /bye >/dev/null
#alias gpg="gpg2"
#alias sha256="sha256sum"
#alias sha512="sha512sum"
