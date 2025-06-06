#!/bin/bash

source source/lib.sh

PLUG=~/.local/share/nvim/site/autoload/plug.vim
[ ! -e $PLUG ] && curl -fLo $PLUG --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

safe_ln $(pwd)/app/nvim/files/ ~/.config/nvim

[ ! -d $HOME/.local/share/nvim/site/autoload/vim-polyglot ] && \
  nvim -c "PlugInstall | :q | :q"

exit 0
