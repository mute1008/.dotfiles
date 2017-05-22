#!/bin/bash
mkdir -p ~/.config/nvim
cp ./vim/nvim/* ~/.config/nvim/
cp ./vim/.vimrc ~/.vimrc
cp ./.tmux.conf ~/.tmux.conf
cp ./.bash_profile ~/.bash_profile
cp ./.tmux.conf ~/.tmux.conf

# GDB
if [ `uname` == 'Linux' ]; then
  wget -q -O- https://github.com/hugsy/gef/raw/master/gef.sh | sh
  echo "disassembly-flavor intel" >> $HOME/.gdbinit
fi
