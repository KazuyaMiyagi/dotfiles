autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# https://nerdfonts.com/
readonly AWS_SYMBOL="%F{#D86613} %f"
readonly AWS_SESSION_EXPIRATION_SYMBOL="%F{#D6242D} %f"
readonly AWS_CREDENTIAL_EXPIRATION_SYMBOL="%F{#D6242D} %f"
readonly TF_WORKSPACE_SYMBOL="%F{#844FBA} %f"
readonly GIT_SYMBOL="%F{#f64d27}󰊢 %f"
readonly GIT_STAGED_SYMBOL="✔︎"
readonly GIT_UNSTAGED_SYMBOL="+"
readonly GIT_UNTRACKED_SYMBOL="?"

zstyle ":vcs_info:*" check-for-changes true
zstyle ":vcs_info:*" check-for-staged-changes true
zstyle ":vcs_info:*" stagedstr "${GIT_STAGED_SYMBOL}"
zstyle ":vcs_info:*" unstagedstr "${GIT_UNSTAGED_SYMBOL}"
zstyle ":vcs_info:*" formats "%s(%b[%u%c])"
zstyle ":vcs_info:*" actionformats "%s(%b|%a[%u%c])"

_init_psvar_precmd() {
    psvar=()
}

_vcs_info_precmd() {
    vcs_info
    [[ -n "${vcs_info_msg_0_}" ]] && psvar[1]="${vcs_info_msg_0_}"
    [[ -n "${vcs_info_msg_1_}" ]] && psvar[2]="${vcs_info_msg_1_}"
}

_set_aws_info_precmd() {
    if [[ -n "${AWS_PROFILE}" ]]; then
        # アカウントの色を取得（取得できない場合は空）
        local cache_dir="${XDG_CACHE_HOME:-${HOME}/.cache}"
        local cache_file="${cache_dir}/aws_profile_colors"
        local account_color=""

        # キャッシュファイルから読み込み
        if [[ -f "${cache_file}" ]]; then
            local cached_line
            cached_line=$(grep "^${AWS_PROFILE}=" "${cache_file}" 2>/dev/null)
            if [[ -n "${cached_line}" ]]; then
                account_color="${cached_line#*=}"
            fi
        fi

        # キャッシュにない場合はAPIから取得
        if [[ -z "${account_color}" ]]; then
            local aws_env_vars color_response
            aws_env_vars=$(aws configure export-credentials --profile "${AWS_PROFILE}" --format env 2>/dev/null)

            if [[ $? -eq 0 && -n "${aws_env_vars}" ]]; then
                color_response=$(eval "${aws_env_vars}" && \
                                curl -s "https://uxc.us-east-1.api.aws/v1/account-color" \
                                --aws-sigv4 "aws:amz" \
                                --user "${AWS_ACCESS_KEY_ID}:${AWS_SECRET_ACCESS_KEY}" \
                                -H "X-Amz-Security-Token: ${AWS_SESSION_TOKEN}" 2>/dev/null)

                if [[ ${?} -eq 0 && -n "${color_response}" ]]; then
                    local color_name
                    color_name=$(echo "${color_response}" | jq -r '.color // empty' 2>/dev/null)

                    if [[ -n "${color_name}" && "${color_name}" != "null" && "${color_name}" != "none" ]]; then
                        # 色名をzsh色番号に変換（256色対応）
                        # https://docs.aws.amazon.com/ja_jp/awsconsolehelpdocs/latest/gsg/GetAccountColor.html#GetAccountColor-response-elements
                        case "${color_name}" in
                            "pink") account_color="213" ;;      # ピンク
                            "purple") account_color="129" ;;    # 紫
                            "darkBlue") account_color="21" ;;   # 濃い青
                            "lightBlue") account_color="117" ;; # 薄い青
                            "teal") account_color="37" ;;       # ティール
                            "green") account_color="46" ;;      # 緑
                            "yellow") account_color="226" ;;    # 黄
                            "orange") account_color="208" ;;    # オレンジ
                            "red") account_color="196" ;;       # 赤
                        esac

                        # キャッシュファイルに保存
                        if [[ -n "${account_color}" ]]; then
                            echo "${AWS_PROFILE}=${account_color}" >> "${cache_file}"
                        fi
                    fi
                fi
            fi
        fi

        psvar[3]="${account_color}"
        psvar[4]="${AWS_PROFILE}"
    else
        psvar[3]=""
        psvar[4]=""
    fi

    [[ -n "${AWS_SESSION_EXPIRATION}" ]] && psvar[5]="${AWS_SESSION_EXPIRATION}"
    [[ -n "${AWS_CREDENTIAL_EXPIRATION}" ]] && psvar[6]="${AWS_CREDENTIAL_EXPIRATION}"
}

_set_terraform_info_precmd() {
    [[ -n "${TF_WORKSPACE}" ]] && psvar[7]="${TF_WORKSPACE}"
}

add-zsh-hook precmd _init_psvar_precmd
add-zsh-hook precmd _vcs_info_precmd
add-zsh-hook precmd _set_aws_info_precmd
add-zsh-hook precmd _set_terraform_info_precmd

# https://github.com/zsh-users/zsh/blob/f702e17b14d75aa21bff014168fa9048124db286/Misc/vcs_info-examples#L155-L170

### Display the existence of files not yet known to VCS

### git: Show marker (${GIT_UNTRACKED_SYMBOL}) if there are untracked files in repository
# Make sure you have added staged to your 'formats':  %c
zstyle ":vcs_info:git*+set-message:*" hooks git-untracked

+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == "true" ]] \
                                                                           && git status --porcelain | grep "??" &> /dev/null; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+="${GIT_UNTRACKED_SYMBOL}"
    fi
}

# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
export PROMPT="
[%n@%m %3~] %1(V.${GIT_SYMBOL}%1v %2v.)%4(V.${AWS_SYMBOL}AWS_PROFILE(%3(V.%F{%3v}.)%4v%3(V.%f.)) .)%5(V.${AWS_SESSION_EXPIRATION_SYMBOL}AWS_SESSION_EXPIRATION(%5v%) .)%6(V.${AWS_CREDENTIAL_EXPIRATION_SYMBOL}AWS_CREDENTIAL_EXPIRATION(%6v%) .)%7(V.${TF_WORKSPACE_SYMBOL}TF_WORKSPACE(%7v%) .)%(?..%F{red}EXIT_CODE(%?%)%f)
%(?.%F{green}.%F{red})%(#.#.$)%f "
export RPROMPT=
