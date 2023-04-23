export ZPLUG_HOME="${HOMEBREW_PREFIX}/opt/zplug"

if [ -f "$ZPLUG_HOME/init.zsh" ]; then
    source "$ZPLUG_HOME/init.zsh"

    zplug "mollifier/anyframe"
    if zplug check "mollifier/anyframe"; then
        bindkey "^r" anyframe-widget-put-history
        alias j=anyframe-widget-cd-ghq-repository
    fi

    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-syntax-highlighting"

    zplug "kinjo/geed", as:command, use:"geed-*"

    zplug load
fi
