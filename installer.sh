#!/bin/bash

export PYVERSION2=2.7.13
export PYVERSION3=3.6.1


# ------------------------------------ #
# Install oh-my-zsh
# ------------------------------------ #
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" >/dev/null
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
# tmux yank
# ------------------------------------ #
if [ ! -e ~/.tmux-yank ]; then
  git clone https://github.com/tmux-plugins/tmux-yank ~/.tmux-yank
fi
# ------------------------------------ #


# ------------------------------------ #
# universal-ctags
# ------------------------------------ #
if [ `uname` == 'Darwin' ]; then
  brew tap universal-ctags/universal-ctags
  brew install --HEAD universal-ctags
fi
# ------------------------------------ #

# ------------------------------------ #
# gitの設定
# ------------------------------------ #
git config --global user.name mute1997
git config --global user.email mute1008@gmail.com
git config --global core.excludesfile ~/.gitignore_global
# ------------------------------------ #


# ------------------------------------ #
# MacにGNUのソフトウェアをインストール
# ------------------------------------ #
if [ `uname` == 'Darwin' ]; then
  brew install coreutils binutils findutils
fi
# ------------------------------------ #


# ------------------------------------ #
# fzfのインストール
# ------------------------------------ #
if [[ ! `which fzf` ]];then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  yes | ~/.fzf/install
fi
# ------------------------------------ #


# ------------------------------------ #
# pyenvの設定
# ------------------------------------ #
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
# Install Middleware
# ------------------------------------ #
if [ `uname` == 'Darwin' ]; then
  if [[ ! `which ag` ]];then
    brew install the_silver_searcher
  elif [[ ! `which tig` ]];then
    brew install tig
  elif [[ ! `which ranger` ]];then
    brew install ranger
  elif [[ ! `reattach-to-user-namespace` ]];then
    brew install reattach-to-user-namespace
  fi
fi
# ------------------------------------ #
