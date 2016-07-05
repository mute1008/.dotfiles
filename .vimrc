if &compatible
      set nocompatible
endif
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#end()

syntax on
filetype plugin indent on
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
