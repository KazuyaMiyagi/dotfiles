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
alias tf='terraform'

autoload -Uz add-zsh-hook
autoload -Uz vcs_info

GIT_STAGED_SYMBOL='✔︎'
GIT_UNSTAGED_SYMBOL='+'
GIT_UNTRACKED_SYMBOL='?'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' stagedstr "${GIT_STAGED_SYMBOL}"
zstyle ':vcs_info:*' unstagedstr "${GIT_UNSTAGED_SYMBOL}"
zstyle ':vcs_info:*' formats "%s(%b) %u%c"
zstyle ':vcs_info:*' actionformats "%s(%b|%a) %u%c"
_vcs_info_precmd() {
   vcs_info
   psvar=()
   [[ -n $vcs_info_msg_0_ ]] && psvar[1]=$vcs_info_msg_0_
   [[ -n $vcs_info_msg_1_ ]] && psvar[2]=$vcs_info_msg_1_
   [[ -n $AWS_PROFILE ]] && psvar[3]=$AWS_PROFILE
}
add-zsh-hook precmd _vcs_info_precmd

#https://github.com/zsh-users/zsh/blob/f702e17b14d75aa21bff014168fa9048124db286/Misc/vcs_info-examples#L155-L170

### Display the existence of files not yet known to VCS

### git: Show marker (T) if there are untracked files in repository
# Make sure you have added staged to your 'formats':  %c
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+="${GIT_UNTRACKED_SYMBOL}"
    fi
}
GIT_SYMBOL='%F{202} %f'
AWS_SYMBOL='%F{214} %f'
export PROMPT="
%n%F{magenta}@%f%M [%F{cyan}%c%f] %1(v|%B${GIT_SYMBOL}%1v%b|) %2(v|%B%F{yellow}%2v%f%b|) %3(v|%B${AWS_SYMBOL}AWS_PROFILE(%3v%)%b|)
%(?.%F{green}.%F{red}(%?%))$%f "
export RPROMPT=
