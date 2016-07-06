#!/bin/sh
DOTFILE_DIR=$(cd $(dirname $0) && pwd)

curl --fail --location --create-dirs --output ${DOTFILE_DIR}/vim/autoload/plug.vim \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s -n $DOTFILE_DIR/vim/      ~/.vim
ln -s -n $DOTFILE_DIR/bundle/   ~/.bundle
ln -s    $DOTFILE_DIR/gemrc     ~/.gemrc
ln -s    $DOTFILE_DIR/my.cnf    ~/.my.cnf
ln -s    $DOTFILE_DIR/tmux.conf ~/.tmux.conf
ln -s    $DOTFILE_DIR/gitconfig ~/.gitconfig
ln -s    $DOTFILE_DIR/gitignore ~/.gitignore

echo "source $DOTFILE_DIR/bashrc" >> ~/.bashrc
echo "source $DOTFILE_DIR/zshrc" >> ~/.zshrc
