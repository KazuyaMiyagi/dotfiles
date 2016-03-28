#!/bin/sh
DOTFILE_DIR=$(cd $(dirname $0) && pwd)

curl --fail --location --create-dirs --output ${DOTFILE_DIR}/vim/autoload/plug.vim \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln --symbolic --no-dereference $DOTFILE_DIR/vim/ ~/.vim
ln --symbolic $DOTFILE_DIR/tmux.conf ~/.tmux.conf
ln --symbolic $DOTFILE_DIR/gitconfig ~/.gitconfig
ln --symbolic $DOTFILE_DIR/gitignore ~/.gitignore
ln --symbolic $DOTFILE_DIR/gemrc ~/.gemrc
ln --symbolic $DOTFILE_DIR/my.cnf ~/.my.cnf
ln --symbolic --no-dereference $DOTFILE_DIR/bundle/ ~/.bundle

echo "source $DOTFILE_DIR/bashrc" >> ~/.bashrc
echo "source $DOTFILE_DIR/zshrc" >> ~/.zshrc
