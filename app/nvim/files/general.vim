if has('nvim')
  " ターミナルをESCで抜けられるように
  tnoremap <silent> <ESC> <C-\><C-n> 
endif

" colorscheme設定
set background=dark

" 不可視文字の設定
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" モード切替
inoremap <silent> jj <ESC> 

" タブ,ウインドウ設定
nnoremap s <Nop>
nnoremap st :<C-u>tabnew<CR>
nnoremap s= <C-w>=
nnoremap sv :sv<CR>
nnoremap vs :vs<CR>
nnoremap sh :call MaximumWindow("h")<CR>
nnoremap sj :call MaximumWindow("j")<CR>
nnoremap sk :call MaximumWindow("k")<CR>
nnoremap sl :call MaximumWindow("l")<CR>
nnoremap K gt
nnoremap J gT
nnoremap sq <C-w>q
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap s- <C-w>_

" スクロール設定
nnoremap D <C-d>
nnoremap U <C-u>

" 汎用設定
syntax on
filetype plugin indent on
set tabstop=2 shiftwidth=2 autoindent expandtab number mouse=a ambiwidth=double cindent hidden clipboard+=unnamedplus sh=zsh
au FileType go setlocal sw=4 ts=4 sts=4 noet

" undo
set undofile
set undodir=~/.cache/undo/

" clickboard
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
