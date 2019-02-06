export PROMPT="%F{cyan}${USER}%F{magenta}@%F{cyan}${HOST}%f $PROMPT"
export RPROMPT="(%F{green}%~%f)[%*]"
export LESSCHARSET=utf-8
export PATH=/usr/local/sbin:~/bin:~/.composer/vendor/bin:$PATH
p() { peco | while read LINE; do $@ $LINE; done }
alias o='git ls-files | p open'
alias j='ghq list -p | p cd'
alias be='bundle exec'
eval "$(direnv hook zsh)"
eval "$(rbenv init -)"
export PATH="$GOPATH/bin:$PATH"
export GOPATH="$HOME/.go"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.nodenv/shims:$PATH"
eval "$(nodenv init -)"

alias phpunit-coverage='phpunit --coverage-html reports --coverage-clover reports/coverage.xml'
alias tree='tree -N -C'
export DOCKER_BUILDKIT=1
