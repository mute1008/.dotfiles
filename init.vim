if $coompatible
  set nocompatible
endif

set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('rust-lang/rust.vim')

call dein#end()

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
