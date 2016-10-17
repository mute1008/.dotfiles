filetype plugin indent on

set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
set number

let mapleader = ","
autocmd BufNewFile,BufRead *.py nnoremap <Leader>r :<C-u>!python3 %<CR>
autocmd BufNewFile,BufRead *.cpp nnoremap <Leader>r :<C-u>!clang++ -std=c++11 % && ./a.out && rm -f a.out<CR>
