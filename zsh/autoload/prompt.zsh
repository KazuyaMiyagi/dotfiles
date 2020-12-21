autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# https://nerdfonts.com/
readonly AWS_SYMBOL='%F{214} %f'
readonly GIT_SYMBOL='%F{202} %f'
readonly GIT_STAGED_SYMBOL='✔︎'
readonly GIT_UNSTAGED_SYMBOL='+'
readonly GIT_UNTRACKED_SYMBOL='?'

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

# https://github.com/zsh-users/zsh/blob/f702e17b14d75aa21bff014168fa9048124db286/Misc/vcs_info-examples#L155-L170

### Display the existence of files not yet known to VCS

### git: Show marker (${GIT_UNTRACKED_SYMBOL}) if there are untracked files in repository
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

export PROMPT="
[%n@%m %3~] %1(v|${GIT_SYMBOL}%1v|) %2(v|%2v|) %3(v|${AWS_SYMBOL}AWS_PROFILE(%3v%)|) %(?..%F{red}EXIT_CODE(%?%)%f)
%(?.%F{green}.%F{red})%(#.#.$)%f "
export RPROMPT=
