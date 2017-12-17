#!/bin/bash

export PYVERSION2=2.7.13
export PYVERSION3=3.6.1


# ------------------------------------ #
mkdir -p ~/.config/nvim
cp ./nvim/* ~/.config/nvim/

cp ./.bashrc ~/.bashrc
cp ./.bash_profile ~/.bash_profile
cp ./.tmux.conf ~/.tmux.conf
cp ./.gitignore_global ~/.gitignore_global
cp ./.globalrc ~/.globalrc
cp ./.Xdefaults ~/.Xdefaults
cp -r ./.xmonad ~/.xmonad

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
# ------------------------------------ #


# universal-ctags #
# ------------------------------------ #
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
# ------------------------------------ #

# ------------------------------------ #
# gitの設定
git config --global user.name mute1997
git config --global user.email mute1008@gmail.com
git config --global core.excludesfile ~/.gitignore_global
# ------------------------------------ #


# ------------------------------------ #
# MacにGNUのソフトウェアをインストール
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
  source ~/.bashrc
  pyenv install $PYVERSION2
  pyenv install $PYVERSION3

  # pyversion3
  pyenv global $PYVERSION3
  pip install neovim
fi
# ------------------------------------ #

# ------------------------------------ #
if [ `uname` == 'Darwin' ]; then
  # agのインストール
  if [[ ! `which ag` ]];then
    brew install the_silver_searcher
  fi

  # tigのインストール
  if [[ ! `which tig` ]];then
    brew install tig
  fi

  if [[ ! `which ranger` ]];then
    brew install ranger
  fi
fi
# ------------------------------------ #
