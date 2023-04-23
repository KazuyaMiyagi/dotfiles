autoload -Uz colors && colors
export LS_COLORS=Gxfxcxdxbxegedabagacad
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
