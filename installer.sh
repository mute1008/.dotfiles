#!/bin/bash

# ------------------------------------ #
mkdir -p ~/.config/nvim
cp ./nvim/* ~/.config/nvim/

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
# Mac用に必要なソフトウェアをインストール
if [ `uname` == 'Darwin' ]; then
  brew install coreutils binutils findutils
fi
# ------------------------------------ #


# ------------------------------------ #
# fzfのインストール
if [[ ! `which fzf` ]];then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  yes | ~/.fzf/install
fi
# ------------------------------------ #


# ------------------------------------ #
# pyenvの設定
if [[ ! `which pyenv` ]];then
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
fi
# ------------------------------------ #


# ------------------------------------ #
# GNU globalのインストール
if [[ ! `which global` ]];then
  curl -O http://tamacom.com/global/global-6.5.7.tar.gz
  tar xvf global-6.5.7.tar.gz
  cd global-6.5.7
  ./configure && make && sudo make install
  cd .. && rm -rf global-6.5.7 global-6.5.7.tar.gz
  sudo sed -ie "1s/.*/#\!\/usr\/bin\/env python/g" /usr/local/share/gtags/script/pygments_parser.py
  curl -O ~/.globalrc https://raw.githubusercontent.com/yoshizow/global-pygments-plugin/master/sample.globalrc
fi
# ------------------------------------ #
