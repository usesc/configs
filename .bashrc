# .bashrc

_gcipps1_() {
  ip -4 -o addr show scope global | awk -F '[ /]+' 'NR==1{print $4; exit}'
}

#PS1='\[\e[0;2m\]\$ \[\e[0m\]\u\[\e[0;2m\]@\[\e[0m\]\h \[\e[0m\](\[\e[0m\]\W\[\e[0m\]) \[\e[0;1m\]~ \[\e[0m\]'
#PS1='\[\e[32m\]$ \[\e[34m\]\u\[\e[1;37m\]@\[\e[35m\]$(_gcipps1_) \[\e[2;37m\](\w) \[\e[1;32m\]~\[\e[0m\] '
PS1='\[\e[32m\]\$ \[\e[34m\]\u \[\e[0;37m\]in \[\e[35m\]\W \[\e[34m\]> \[\e[0m\]'

[[ $- != *i* ]] && return

xset b off

shopt -s cdspell
shopt -s checkwinsize

export EDITOR='nvim'
export PAGER='less'
export HISTSIZE=5000
export HISTFILESIZE=100000
export TZ='America/Chicago'

# fuzzy - fzv = fuzzy view, fze = fuzzy edit
alias fzv='fzf --preview "bat --style=numbers --color=always {}"'
alias fze='fzf --preview "bat --style=numbers --color=always {}" | xargs -r "$EDITOR"'

alias brc='$EDITOR ~/.bashrc'

# fv = file viewer
alias fv='bat --paging=never'

# cd aliases
alias ~='cd ~'
alias ..='cd ..'

# list
alias ls='ls --color=auto'
alias lsa='ls -A'
alias lsl='ls -l'
alias lsal='ls -Al'
alias lt='ls --human-readable --block-size=1 --size -1 -S --classify'

# clear + reset
alias cls='clear && ls -A'
alias rst='reset'

# interactive mode
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# buidling
alias mk='make'
alias mj='make -j$(nproc)'
alias mb='make -B'
alias mbj='make -Bj$(nproc)'

# void linux
alias xi='sudo xbps-install' xbpsi='sudo xbps-install'
alias xs='xbps-query -Rs'    xbpsq='xbps-query -Rs'
alias xr='sudo xbps-remove'  xbpsr='sudo xbps-remove'
alias xl='xbps-query -l'     xbpsl='xbps-query -l'
alias vsv='sudo vsv' # great utility, love it

# stuff
alias psg='ps aux | grep -i'
alias cpu10='ps aux --sort=-%cpu | head -10'
alias sen='sensors -f -A'
alias lers='sudo lsof -i -P | grep --ignore-case listen' 

add-bin() {
  if [[ -z "$1" ]]; then
    echo "Usage: add-bin <file>"
    return 1
  fi

  if [[ ! -f "$1" ]]; then
    echo "fatal error: file '$1' not found."
    return 1
  fi

  sudo cp "$1" /usr/bin 
}