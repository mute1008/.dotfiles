#!/bin/bash

PYVERSION2=2.7.13
PYVERSION3=3.6.1

# ------------------------------------ #
# 依存関係確認
which git && which ruby && which gcc
if [[ ! $? ]];then
  echo "git, ruby, gccをインストールしてください"
fi
# ------------------------------------ #


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
# gitの設定
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
  pyenv install $PYVERSION2
  pyenv install $PYVERSION3

  # pyversion2
  pyenv global $PYVERSION2
  pip install Pygments

  # pyversion3
  pyenv global $PYVERSION3
  pip install neovim
fi
# ------------------------------------ #


# ------------------------------------ #
# agのインストール
if [[ ! `which ag` ]];then
  # TODO: Linuxだとうまくインストールできないことあり
fi

# GNU globalのインストール
if [[ ! `which global` ]];then
  brew install global
fi

# tigのインストール
if [[ ! `which tig` ]];then
  brew install tig
fi

# neovimのインストール
if [[ ! `which nvim` ]];then
  brew install neovim
fi

# tmuxのインストール
if [[ ! `which tmux` ]];then
  brew install tmux
fi
# ------------------------------------ #
