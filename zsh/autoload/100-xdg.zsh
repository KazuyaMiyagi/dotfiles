# https://wiki.archlinux.jp/index.php/XDG_Base_Directory_%E3%82%B5%E3%83%9D%E3%83%BC%E3%83%88

# XDG Settings
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

# zsh
export HISTFILE="${XDG_DATA_HOME}/zsh/history"

# go
export GOPATH="${XDG_DATA_HOME}/git"

# ghq
export GHQ_ROOT="${XDG_DATA_HOME}/git/src"

# Ruby#RubyGems
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem"

# Ruby#Bundler
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}/bundle"
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME}/bundle"

# tig
export TIGRC_USER="${XDG_CONFIG_HOME}/tig/tigrc"

# asdf
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="tool-versions"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_GEM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/asdf/default-gems-packages"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/asdf/default-npm-packages"
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/asdf/default-python-packages"
