source ~/.config/nvim/lib.vim
source ~/.config/nvim/general.vim

call plug#begin('~/.local/share/nvim/site/autoload/')
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/neco-syntax'
Plug 'ujihisa/neco-look'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/vinarise.vim'
Plug 'itchyny/lightline.vim'
Plug 'tyru/caw.vim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim'
Plug 'iberianpig/tig-explorer.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'jonathanfilip/vim-lucius'
Plug 'lambdalisue/suda.vim'

call plug#end()

set termguicolors
colorscheme lucius
LuciusDarkLowContrast

for f in split(glob('~/.config/nvim/*.vim'), '\n')
  if match(fnameescape(f), 'init.vim') == -1 && match(fnameescape(f), 'general.vim') == -1
    execute 'source' f
  endif
endfor
