if [[ "$(/usr/bin/uname)" == "Darwin" ]] ; then
    if [[ "$(/usr/bin/uname -m)" == "arm64" ]] ; then
        export HOMEBREW_PREFIX="/opt/homebrew"
    else
        export HOMEBREW_PREFIX="/usr/local"
    fi
    eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

    # for ruby-build
    # https://github.com/rbenv/ruby-build/wiki#macos
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"
    # https://github.com/rbenv/ruby-build/discussions/1933#discussioncomment-2131144
    export CPPFLAGS="-I$(brew --prefix)/opt/capstone/include"
    export LDFLAGS="-L$(brew --prefix)/opt/capstone/lib"
fi
