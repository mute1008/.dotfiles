if has('nvim')
    " ターミナルをESCで抜けられるように
    tnoremap <silent> <ESC> <C-\><C-n> 
endif

" colorscheme設定
" -----------------------------------------------------
set background=dark
autocmd VimEnter * colorscheme moneyforward
" -----------------------------------------------------

" filetype設定
" -----------------------------------------------------
autocmd BufRead,BufNewFile *.jsx setfiletype javascript.jsx
autocmd BufRead,BufNewFile *.js setfiletype javascript.jsx
autocmd BufRead,BufNewFile *.rs setfiletype rust
autocmd BufRead,BufNewFile *.vue setfiletype html

autocmd FileType php :setlocal expandtab
autocmd FileType php :setlocal softtabstop=4
autocmd FileType php :setlocal shiftwidth=4
" -----------------------------------------------------

" タブ,ウインドウ設定
" -----------------------------------------------------
set scrolloff=1000 " 常にカーソルが真ん中に来るように
nnoremap s <Nop>
nnoremap st :<C-u>tabnew<CR>
nnoremap s= <C-w>=
nnoremap sv :sv<CR>
nnoremap vs :vs<CR>
nnoremap sw <C-w>w
" -----------------------------------------------------

" dein設定
" -----------------------------------------------------
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
" -----------------------------------------------------

" 汎用設定
" -----------------------------------------------------
syntax on
filetype plugin indent on
set tabstop=2 shiftwidth=2 autoindent expandtab number mouse=a ambiwidth=double
" -----------------------------------------------------

" 補完
" 参考 : http://io-fia.blogspot.jp/2012/11/vimvimrc.html
" -----------------------------------------------------
set completeopt=menuone "補完候補が一つでもポップアップする

" キーが押されたらキーワード補完
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec "imap " . k . " " . k . "<C-N><C-P>"
endfor
imap <expr> <TAB> pumvisible() ? "\<Down>" : "\<Tab>"

" タブを押したらオムニ補完
" 参考 : http://vim.wikia.com/wiki/Smart_mapping_for_tab_completion
function! TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if ( has_slash )
    return "\<C-X>\<C-F>\<C-P>"                         " file matching
  else
    return "\<C-X>\<C-O>\<C-P>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=TabComplete()<CR>
" -----------------------------------------------------
