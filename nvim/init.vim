filetype plugin indent on
set tabstop=4 autoindent expandtab shiftwidth=4 number
let mapleader=','
autocmd BufNewFile,BufRead *.py nnoremap <Leader>r :<C-u>!python3 %<CR>
autocmd BufNewFile,BufRead *.cpp nnoremap <Leader>r :<C-u>!clang++ -std=c++11 % && ./a.out && rm -f a.out<CR>
autocmd BufNewFile,BufRead *.java nnoremap <Leader>r :<C-u>!cd %:h && javac % && java %:r && rm -f *.class<CR>
autocmd BufNewFile,BufRead *.rs nnoremap <Leader>r :<C-u>!rustc % -o a && ./a && rm a<CR>

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.config/nvim')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

