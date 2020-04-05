source lib/symlink.sh

if [ ! "`pip3 freeze | grep pynvim`" ];then
  pip3 install pynvim --user
fi

if [ ! "`pip3 freeze | grep nvim`" ];then
  pip3 install neovim --user
fi

# install vim-plug
if [ ! -e ~/.local/share/nvim/site/autoload/plug.vim ];then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

eval $(python -c "import glob,os;print('declare -a array=(', ' '.join(list(map(lambda x: os.path.split(x)[1], glob.glob('./app/nvim/files/*')))), ')')")
for ((i = 0; i < ${#array[@]}; i++)) {
    symlink ./app/nvim/files/${array[i]} ~/.config/nvim/${array[i]}
}

nvim -c "PlugInstall | :q | :q"
