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

call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
