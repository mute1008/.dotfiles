source ~/.config/nvim/lib.vim
source ~/.config/nvim/general.vim

call plug#begin('~/.local/share/nvim/site/autoload/')
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/neco-syntax'
Plug 'ujihisa/neco-look'
Plug 'anoike/vim-moneyforward'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/vinarise.vim'
Plug 'itchyny/lightline.vim'
Plug 'tyru/caw.vim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
call plug#end()

colorscheme moneyforward

for f in split(glob('~/.config/nvim/*.vim'), '\n')
  if match(fnameescape(f), 'init.vim') == -1 && match(fnameescape(f), 'general.vim') == -1
    execute 'source' f
  endif
endfor
