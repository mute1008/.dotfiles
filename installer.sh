#!/bin/bash

export PYVERSION2=2.7.13
export PYVERSION3=3.6.1


# ------------------------------------ #
# Install oh-my-zsh
# ------------------------------------ #
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null
# ------------------------------------ #


# ------------------------------------ #
# Install dotfiles
# ------------------------------------ #
mkdir -p ~/.config/nvim
cp ./nvim/* ~/.config/nvim/
cp ./.zshrc ~/.zshrc
cp ./.tmux.conf ~/.tmux.conf
cp ./.gitignore_global ~/.gitignore_global
cp ./.globalrc ~/.globalrc
cp ./.Xdefaults ~/.Xdefaults
cp -r ./.xmonad ~/.xmonad
# ------------------------------------ #


# ------------------------------------ #
# gitの設定
# ------------------------------------ #
git config --global user.name mute1997
git config --global user.email mute1008@gmail.com
git config --global core.excludesfile ~/.gitignore_global
# ------------------------------------ #


# ------------------------------------ #
# pyenvの設定
# ------------------------------------ #
if [[ ! -e `which pyenv` ]];then
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
# Install Middleware for Mac
# ------------------------------------ #
if [ `uname` == 'Darwin' ]; then
  if [[ ! -e `which ag` ]];then
    brew install the_silver_searcher
  elif [[ ! -e `which tig` ]];then
    brew install tig
  elif [[ ! -e `which ranger` ]];then
    brew install ranger
  elif [[ ! -e `which reattach-to-user-namespace` ]];then
    brew install reattach-to-user-namespace
  elif [[ ! -e `which gfind` ]]; then
    brew install coreutils binutils findutils
  elif [[ `ctags --version | grep "Universal Ctags"` = "" ]];then
    brew tap universal-ctags/universal-ctags
    brew install --HEAD universal-ctags
  fi
fi
# ------------------------------------ #
