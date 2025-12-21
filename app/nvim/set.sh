#!/bin/bash

source source/lib.sh

PLUG=~/.local/share/nvim/site/autoload/plug.vim
[ ! -e $PLUG ] && curl -fLo $PLUG --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

safe_ln $(pwd)/app/nvim/files/ ~/.config/nvim

exit 0
