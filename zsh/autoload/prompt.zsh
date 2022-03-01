autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# https://nerdfonts.com/
readonly AWS_SYMBOL='%F{#D86613} %f'
readonly AWS_SESSION_EXPIRATION_SYMBOL='%F{#D6242D} %f'
readonly TF_WORKSPACE_SYMBOL="%F{#844FBA} %f"
readonly GIT_SYMBOL='%F{#f64d27} %f'
readonly GIT_STAGED_SYMBOL='✔︎'
readonly GIT_UNSTAGED_SYMBOL='+'
readonly GIT_UNTRACKED_SYMBOL='?'

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' stagedstr "${GIT_STAGED_SYMBOL}"
zstyle ':vcs_info:*' unstagedstr "${GIT_UNSTAGED_SYMBOL}"
zstyle ':vcs_info:*' formats "%s(%b[%u%c])"
zstyle ':vcs_info:*' actionformats "%s(%b|%a[%u%c])"

_vcs_info_precmd() {
   vcs_info
   psvar=()
   [[ -n $vcs_info_msg_0_ ]] && psvar[1]=$vcs_info_msg_0_
   [[ -n $vcs_info_msg_1_ ]] && psvar[2]=$vcs_info_msg_1_
   [[ -n $AWS_PROFILE ]] && psvar[3]=$AWS_PROFILE
   [[ -n $AWS_SESSION_EXPIRATION ]] && psvar[4]=$AWS_SESSION_EXPIRATION
   [[ -n $TF_WORKSPACE ]] && psvar[5]=$TF_WORKSPACE
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

# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
export PROMPT="
[%n@%m %3~] %1(V.${GIT_SYMBOL}%1v %2v.)%3(V.${AWS_SYMBOL}AWS_PROFILE(%3v%) .)%4(V.${AWS_SESSION_EXPIRATION_SYMBOL}AWS_SESSION_EXPIRATION(%4v%) .)%5(V.${TF_WORKSPACE_SYMBOL}TF_WORKSPACE(%5v%) .)%(?..%F{red}EXIT_CODE(%?%)%f)
%(?.%F{green}.%F{red})%(#.#.$)%f "
export RPROMPT=
