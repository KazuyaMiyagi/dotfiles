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
    # configure の pipe2 検出は char pipe2(); を自前宣言してリンクするだけで、ヘッダの
    # availability 属性を見ない。macOS 27.0 導入予定として weak import される pipe2 を
    # 「あり」と誤検出し、miniruby が NULL を呼んで SIGSEGV する。conftest がヘッダを
    # 読まない以上 -Werror=unguarded-availability-new では防げないため、キャッシュ変数で
    # 検出結果を直接潰す。Apple が pipe2 を実装したら外す。
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=${OPENSSL_PREFIX} ac_cv_func_pipe2=no"

    # for mysql gem
    export LIBRARY_PATH="${LIBRARY_PATH}:$(brew --prefix zstd)/lib/"
fi
