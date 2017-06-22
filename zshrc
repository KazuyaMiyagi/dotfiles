export PROMPT="%F{cyan}${USER}%f@%F{cyan}${HOST}%f $PROMPT"
export LESSCHARSET=utf-8
export PATH=/usr/local/sbin:~/bin:~/.composer/vendor/bin:$PATH
p() { peco | while read LINE; do $@ $LINE; done }
alias o='git ls-files | p open'
alias j='ghq list -p | p cd'
alias be='bundle exec'
alias composer='docker run --rm -v $(pwd):/app -v ~/.composer:/composer composer/composer'
eval "$(direnv hook zsh)"
eval "$(rbenv init -)"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/Library/Python/2.7/bin:$PATH"
