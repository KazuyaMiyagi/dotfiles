export PROMPT="%F{cyan}${USER}%f at %F{cyan}${HOST}%f $PROMPT"
export LESSCHARSET=utf-8
export PATH=/usr/local/sbin:~/bin:~/.composer/vendor/bin:$PATH
p() { peco | while read LINE; do $@ $LINE; done }

alias j='ghq list -p | p cd'
alias bd=boot2docker
alias be='bundle exec'
