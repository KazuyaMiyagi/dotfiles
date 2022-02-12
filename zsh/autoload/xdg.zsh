# https://wiki.archlinux.jp/index.php/XDG_Base_Directory_%E3%82%B5%E3%83%9D%E3%83%BC%E3%83%88

# XDG Settings
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# zsh
export HISTFILE="$XDG_DATA_HOME/zsh/history"

# go
export GOPATH="$XDG_DATA_HOME/git"

# ghq
export GHQ_ROOT="$XDG_DATA_HOME/git/src"

# RubyGems
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"

# tmux
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

# tig
export TIGRC_USER="$XDG_CONFIG_HOME/tig/tigrc"

# asdf
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="${XDG_CONFIG_HOME}/tool-versions"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
