#!/bin/bash

# ------------------------------------ #
echo "dotfiles setting"
mkdir -p ~/.config/nvim
cp ./vim/nvim/* ~/.config/nvim/

cp ./.tmux.conf ~/.tmux.conf
cp ./.bash_profile ~/.bash_profile
# ------------------------------------ #

# ------------------------------------ #
# vimとnvimで設定ファイルの共通化
rm -r ~/.vim # シンボリックリンクの削除
rm ~/.vimrc

ln -s ~/.config/nvim ~/.vim  # vimの設定にnvimの設定をシンボリックリンク
ln -s ~/.config/nvim/init.vim ~/.vimrc 
# ------------------------------------ #

# ------------------------------------ #
echo "git setting"
git config --global user.name mute1997
git config --global user.email mute1008@gmail.com
# ------------------------------------ #

# ------------------------------------ #
# OSごとにlsの設定を追加
if [ `uname` == 'Linux' ]; then
  echo "alias ls='ls --color'" >> ~/.bash_profile
else
  echo "alias ls='ls -G'" >> ~/.bash_profile
fi
# ------------------------------------ #

# ------------------------------------ #
# fzfのインストール
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install
# ------------------------------------ #
