#!/bin/bash

# ------------------------------------ #
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


# ------------------------------------ #
# pyenvの設定
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
source ~/.bash_profile
pyenv install 2.7.13
pyenv install 3.6.1

# 2.7.13
pyenv global 2.7.13
pip install Pygments

# 3.6.1
pyenv global 3.6.1
pip install neovim
# ------------------------------------ #


# ------------------------------------ #
# GNU globalの設定
curl -O http://tamacom.com/global/global-6.5.7.tar.gz
tar xvf global-6.5.7.tar.gz
cd global-6.5.7
./configure && make && sudo make install
rm -rf global-6.5.7 global-6.5.7.tar.gz && cd ..
# ------------------------------------ #


# ------------------------------------ #
# global-pygments-pluginのインストール
pyenv global 2.7.13
pyenv global
git clone https://github.com/yoshizow/global-pygments-plugin
cd global-pygments-plugin
./reconf.sh && ./configure && make && sudo make install
curl -O https://raw.githubusercontent.com/yoshizow/global-pygments-plugin/master/sample.globalrc
cp sample.globalrc ~/.globalrc
rm -rf global-pygments-plugin && pyenv global 3.6.1 && cd ..
# ------------------------------------ #
