. ${HOMEBREW_PREFIX}/opt/asdf/asdf.sh
 eval "$(asdf exec direnv hook zsh)"

export POWERLINE_REPOSITORY_ROOT=$(asdf exec pip show powerline-status | grep Location | cut -d' ' -f 2)
