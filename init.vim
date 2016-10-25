syntax on
filetype plugin indent on
set tabstop=4 autoindent expandtab shiftwidth=4 number autochdir
let mapleader=','
autocmd BufNewFile,BufRead *.py nnoremap <Leader>r :<C-u>!python3 %<CR>
autocmd BufNewFile,BufRead *.cpp nnoremap <Leader>r :<C-u>!clang++ -std=c++11 % && ./a.out && rm -f a.out<CR>
autocmd BufNewFile,BufRead *.java nnoremap <Leader>r :<C-u>!javac % && java %:r && rm -f *.class<CR>
autocmd BufNewFile,BufRead *.rs nnoremap <Leader>r :<C-u>!rustc % -o a && ./a && rm a<CR>

