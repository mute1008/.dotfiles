source ~/.config/nvim/lib.vim
source ~/.config/nvim/general.vim

call plug#begin('~/.local/share/nvim/site/autoload/')
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'tyru/caw.vim'
Plug 'Shougo/denite.nvim'
Plug 'rbgrouleff/bclose.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jonathanfilip/vim-lucius'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'lighttiger2505/deoplete-vim-lsp'
Plug 'Shougo/deoplete.nvim'
Plug 'ujihisa/neco-look'
call plug#end()

" set colorschema
colorscheme lucius
LuciusDarkLowContrast

" background opacity setting
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none

for f in split(glob('~/.config/nvim/*.vim'), '\n')
  if match(fnameescape(f), 'init.vim') == -1 && match(fnameescape(f), 'general.vim') == -1
    execute 'source' f
  endif
endfor
