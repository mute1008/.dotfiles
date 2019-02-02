#!/bin/bash

source lib/symlink.sh

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

eval $(python -c "import glob,os;print('declare -a array=(', ' '.join(list(map(lambda x: os.path.split(x)[1], glob.glob('./app/nvim/files/*')))), ')')")
for ((i = 0; i < ${#array[@]}; i++)) {
    symlink ./app/nvim/files/${array[i]} ~/.config/nvim/${array[i]}
}
