# install vim-plug

PLUG=~/.local/share/nvim/site/autoload/plug.vim
[ ! -e $PLUG ] && curl -fLo $PLUG --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/nvim/
ls app/nvim/files | xargs -n1 -I{} bash -c "rm -f ~/.config/nvim/{} && ln -s $(pwd)/app/nvim/files/{} ~/.config/nvim/{}"

nvim -c "PlugInstall | :q | :q"
