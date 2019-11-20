# https://github.com/drduh/config/blob/master/zshrc
HISTFILE=~/.zsh_history
HISTSIZE=500
SAVEHIST=$HISTSIZE
PAGER=less
EDITOR=vim
VISUAL=vim
LANG=en_US.UTF-8
umask 077
export LC_ALL=C
export LC_CTYPE=C
autoload -U colors && colors
autoload -U compinit && compinit
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
zstyle ':completion:*' auto-description 'specify %d'
zstyle ':completion:*' cache-path ~/.zsh_cache
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' file-sort modification reverse
zstyle ':completion:*' format 'completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' hosts off
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' use-cache on
zstyle ':completion:*' verbose yes
PS1="%{$fg[red]%}%h %{$fg[yellow]%}%~ %{$reset_color%}% "
SPROMPT="$fg[red]%R$reset_color did you mean $fg[green]%r?$reset_color "
function adbpkg {
  for p in $(adb shell pm list package|awk -F"package:" '{print $2}'); \
    do echo -n "$p: "
      adb shell dumpsys package $p | \
        grep -i versionname | \
        awk -F"=" '{print $2}'
  done > adb.pkg.$(date +%F)
}
function calc { awk "BEGIN { print "$*" }" }
function colours {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}
function convert_secs {
  ((h=${1}/3600))
  ((m=(${1}%3600)/60))
  ((s=${1}%60))
  printf "%02d:%02d:%02d\n" $h $m $s
}
function e { awk -v c=${1} -v l=${2} 'BEGIN { print log(c^l) }' }
function f { find . -iname "*${1}*" }
function fd { find . -iname "*${1}*" -type d }
function gas { whois -h whois.radb.net '!g'${1} }
function png2jpg {
  for i in *.png ; do
    f=${i%.*}
    convert "$f.png" "$f.jpg"
  done
}
function zshaddhistory {
  whence ${${(z)1}[1]} >| /dev/null || return 1
  local line cmd
  line=${1%%$'\n'}
  cmd=${line%% *}
  [[ ${#line} -ge 5 \
    && ${cmd} != (apm|base64|bzip2|cal|calc|cat|cd|chmod|cp|curl|cvs|date|df|diff|dig|disklabel|dmesg|doas|du|e|egrep|enc|ent|exiftool|f|fdisk|feh|file|find|gimp|git|gpg|grep|hdiutil|head|hostname|ifconfig|kill|less|ls|mail|make|man|mkdir|mount|mpv|mv|nc|openssl|patch|pdf|pdfinfo|pgrep|ping|pkg_info|pkill|ps|rcctl|rm|rsync|scp|scrot|set|sha256|sort|srm|ssh|ssh-keygen|stat|strip|sudo|sysctl|tar|tmux|top|umount|uname|unzip|uptime|useradd|vlc|vi|vim|wc|wget|which|whoami|whois|wireshark|xclip|xxd|youtube-dl)
  ]]
}
function path {
  if [[ -d "$1" ]] ; then
    if [[ -z "$PATH" ]] ; then
      export PATH=$1
    else
      export PATH=$PATH:$1
    fi
  fi
}
export PATH=''
path /usr/local/sbin
path /usr/local/bin
path /usr/sbin
path /usr/bin
path /sbin
path /bin
#path /usr/games
#path /usr/X11R6/bin
alias -g H='| head'
alias -g L='| less'
alias -g S='| sort'
alias -g T='| tail'
alias -g XC='| xclip -i'
alias -g XP='| xclip -o'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias l="ls -ltrhsa"
alias ls="ls -lha"
alias t="tail -f"
alias v="vim -p"
alias md="mkdir -p"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias ea="cat /proc/sys/kernel/random/entropy_avail"
alias cr="chrome --enable-unveil --incognito --ssl-version-min=tls1.2 --cipher-suite-blacklist=0x009c,0x009d,0x002f,0x0035,0x000a,0xc013,0xc014"
alias ff_resize="xdotool windowsize \$(xdotool search --onlyvisible --name firefox) 2560 1660"
alias ff="firefox --ProfileManager --no-remote -jsconsole"
alias tb="thunderbird --ProfileManager --no-remote -jsconsole"
alias srl="doas cu -r -s 115200 -l cuaU0||sudo minicom -D /dev/ttyUSB0"
alias vpn="ssh -NCL 5555:127.0.0.1:8118 vpn"
alias pdf="mupdf -r180 -CFDF6E3 ${1}"
alias audio="pgrep pulseaudio||pulseaudio &;pacmd list-sinks|egrep '\*|card:'"
alias audio_set="pacmd set-default-sink ${1}"
alias bat="upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E 'state|to\ full|percentage'"
alias cert="openssl req -new -newkey rsa:4096 -sha512 -days 365 -nodes -x509 -keyout s.key -out s.crt && openssl x509 -in s.crt -noout -subject -issuer -enddate"
alias cidr="whois \$(curl -s https://icanhazip.com) | grep CIDR"
alias cpuv="tail -n +1 /sys/devices/system/cpu/vulnerabilities/*"
alias dedupe="find . ! -empty -type f -exec md5sum {} + | sort | uniq -w32 -dD"
alias dump_pflog="tcpdump -ni pflog0 -w pflog-\$(date +%F-%H:%M:%S).pcap 'not icmp6'"
alias dump_syn="tcpdump -ni em0 -w syn-\$(date +%F-%H:%M:%S).pcap 'tcp[13]&2!=0'"
alias dump_udp="tcpdump -ni em0 -w udp-\$(date +%F-%H:%M:%S).pcap 'udp and not port 443'"
alias dump_icmp="tcpdump -ni em0 -w icmp-\$(date +%F-%H:%M:%S).pcap 'icmp'"
alias gpg_restart="pkill pinentry gpg ssh-agent;eval \$(gpg-agent --daemon --enable-ssh-support)"
alias grep_ip="grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}'"
alias grep_url="grep -Eo '(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'"
alias lock="date ; ( sleep 1 && slock ) & ; sleep 2 && systemctl suspend"
alias mac_rand="openssl rand -hex 6|sed 's/\(..\)/\1:/g; s/.$//'"
alias trim="fold -w40 | head -n5 | sed '-es/./ /'{1..40..10}"
alias rand="tr -dc '01' < /dev/urandom | trim ; \
  tr -dc '[:digit:]' < /dev/urandom | trim ; \
  tr -dc '[:upper:]' < /dev/urandom | trim ; \
  tr -dc '[:xdigit:]' < /dev/urandom | trim ; \
  tr -dc '[:alnum:]' < /dev/urandom | trim ; \
  tr -dc '[:graph:]' < /dev/urandom | trim"
#alias enc="gpg -e -a -r foo@duh.to -r 0xFF3E7D88647EBCDB -o ~/out.enc ${1}"
#alias gpg="gpg2"
#alias sha256="sha256sum"
#alias sha512="sha512sum"
#export GPG_TTY="$(tty)"
#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#gpgconf --launch gpg-agent
#gpg-connect-agent updatestartuptty /bye >/dev/null
