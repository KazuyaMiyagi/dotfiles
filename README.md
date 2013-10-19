```
cd $HOME
git clone github.com:KazuyaMiyagi/dotfiles
git submodule init
git submodule update
```

リンクの張り方
```
ln -s dotfiles/vim .vim
ln -s dotfiles/gitconfig .gitconfig
ln -s dotfiles/tmux.conf .tmux.conf
windowsの場合(管理者で)
mklink /d vimfiles dotfiles\vim
mklink gitconfig dotfiles\gitconfig
```
