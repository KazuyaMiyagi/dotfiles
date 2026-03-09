export ZPLUG_HOME="${HOMEBREW_PREFIX}/opt/zplug"

if [ -f "${ZPLUG_HOME}/init.zsh" ]; then
    source "${ZPLUG_HOME}/init.zsh"

    zplug "mollifier/anyframe"
    if zplug check "mollifier/anyframe"; then
        bindkey "^r" anyframe-widget-put-history
        function j() {
            local selected
            selected=$(ghq list | anyframe-selector-auto)
            [[ -n "$selected" ]] && cd "$(ghq root)/$selected"
        }
    fi

    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-syntax-highlighting"

    zplug load
fi
