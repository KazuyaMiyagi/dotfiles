export PROMPT="%F{cyan}${USER}%f at %F{cyan}${HOST}%f $PROMPT"

p() { peco | while read LINE; do $@ $LINE; done }

alias j='ghq list -p | p cd'
alias bd=boot2docker
