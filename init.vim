if &compatible
      set nocompatible
endif
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

"プラグインを消すには
"dein#addを消して、ディレクトリを削除する
call dein#add('Shougo/dein.vim')
call dein#add('rust-lang/rust.vim')
call dein#add('sophacles/vim-processing')
call dein#add('derekwyatt/vim-scala')
call dein#add('thinca/vim-quickrun')
call dein#add('kana/vim-filetype-haskell')

call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

"quickrunの設定
let g:quickrun_config={'*':{'split': ''}}
set splitbelow
nnoremap <Leader>q :<C-u>bw! \[quickrun\ output\]<CR>


if executable("clang++")
  let g:syntastic_cpp_compiler = 'clang++'
  let g:syntastic_cpp_compiler_options = '--std=c++11 --stdlib=libc++'
  let g:quickrun_config = {}
  let g:quickrun_config['cpp/clang++11'] = {
      \ 'cmdopt': '--std=c++11 --stdlib=libc++',
      \ 'type': 'cpp/clang++'
    \ }
  let g:quickrun_config['cpp'] = {'type': 'cpp/clang++11'}
endif
