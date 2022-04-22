. ${HOMEBREW_PREFIX}/opt/asdf/asdf.sh
 eval "$(asdf exec direnv hook zsh)"

export ASDF_HASHICORP_OVERWRITE_ARCH_TERRAFORM="amd64"
export POWERLINE_REPOSITORY_ROOT=$(asdf exec pip show powerline-status | grep Location | cut -d' ' -f 2)
