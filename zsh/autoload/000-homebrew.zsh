if [[ "$(/usr/bin/uname)" == "Darwin" ]]; then
    if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
        export HOMEBREW_PREFIX="/opt/homebrew"
    else
        export HOMEBREW_PREFIX="/usr/local"
    fi
    eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

    # for ruby-build
    # https://github.com/rbenv/ruby-build/wiki#macos
    OPENSSL_PREFIX=$(brew --prefix openssl@3)
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=${OPENSSL_PREFIX}"

    # for mysql gem
    export LIBRARY_PATH="${LIBRARY_PATH}:$(brew --prefix zstd)/lib/"
fi
