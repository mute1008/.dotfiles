#!/bin/sh
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.vim/dein
rm installer.sh
mkdir -p .config/nvim/
cp init.vim ~/.config/nvim/init.vim
