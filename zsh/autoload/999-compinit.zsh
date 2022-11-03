autoload -Uz compinit && compinit
zstyle ":completion:*" menu select
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" format "%B%d%b"

# [Shift-Tab]
bindkey "${terminfo[kcbt]}" reverse-menu-complete

eval "$(kubectl completion zsh)"
