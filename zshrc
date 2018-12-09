# https://github.com/drduh/config/blob/master/zshrc
PAGER=less
EDITOR=vim
VISUAL=vim
LANG=en_US.UTF-8
LC_ALL=$LANG
LC_CTYPE=$LANG
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=$HISTSIZE
autoload -U colors && colors
autoload -U compinit && compinit
autoload -U promptinit && promptinit
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
function calc { awk "BEGIN { print "$*" }" }
function f { find . -iname "*$1*" }
function colours {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}
function convert_secs {
  ((h=${1}/3600))
  ((m=(${1}%3600)/60))
  ((s=${1}%60))
  printf "%02d:%02d:%02d\n" $h $m $s
}
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
    && ${cmd} != ((p|)kill|(s|)rm|(s|cp)|file|feh|man|cat|ls|cd|chmod|mv|tar|ent|less|head|mkdir|ps)
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
#path /usr/X11R6/bin
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#gpgconf --launch gpg-agent
#gpg-connect-agent updatestartuptty /bye >/dev/null
alias -g L='| less'
alias -g H='| head'
alias -g S='| sort'
alias -g T='| tail'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias l="ls -lha"
alias ls="ls -lh"
alias cr="chrome --enable-unveil --incognito"
alias ff="firefox --ProfileManager --no-remote"
alias ff_resize="xdotool windowsize \$(xdotool search --onlyvisible --name firefox) 2560 1660"
alias v="vim"
alias md="mkdir -p"
alias audio="pgrep pulseaudio||pulseaudio &;pacmd list-sinks|egrep '\*|card:'"
alias audio_set="pacmd set-default-sink ${1}"
alias bat="upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E 'state|to\ full|percentage'"
alias cert="openssl req -new -newkey rsa:4096 -sha256 -days 365 \
  -nodes -x509 -keyout s.key -out s.crt && \
  openssl x509 -in s.crt -noout -subject -issuer -enddate"
alias dedupe="find . ! -empty -type f -exec md5sum {} + | sort | uniq -w32 -dD"
alias gpg_restart="pkill pinentry ; pkill gpg-agent ; pkill ssh-agent ; \
  eval \$(gpg-agent --daemon --enable-ssh-support --log-file ~/.gnupg/gpg-agent.log)"
alias grep_ip="grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}'"
alias grep_url="grep -Eo '(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'"
alias lock="date ; ( sleep 1 && slock ) & ; sleep 2 && sudo pm-suspend"
alias mac_rand="openssl rand -hex 6|sed 's/\(..\)/\1:/g; s/.$//'"
alias mac_troll="printf 00:20:91:; openssl rand -hex 3|sed 's/\(..\)/\1:/g; s/.$//'"
alias rand="tr -dc '[:alnum:]<>()$%^&*+=' < /dev/urandom | fold -w30 | head -n 10"
