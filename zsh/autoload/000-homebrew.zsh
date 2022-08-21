if [[ "$(/usr/bin/uname)" == "Darwin" ]] ; then
    if [[ "$(/usr/bin/uname -m)" == "arm64" ]] ; then
        export HOMEBREW_PREFIX="/opt/homebrew"
    else
        export HOMEBREW_PREFIX="/usr/local"
    fi
    eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
fi
