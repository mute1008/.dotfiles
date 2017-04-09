"--------------------------------------
"------command imports-----------------
"--------------------------------------

source ~/.config/nvim/commands.vim

"--------------------------------------
"------main settings-------------------
"--------------------------------------

if has('nvim')
    tnoremap <silent> <ESC> <C-\><C-n> 

    set background=dark
    autocmd VimEnter * colorscheme lucius
endif

autocmd BufRead,BufNewFile *.jsx setfiletype javascript.jsx
autocmd BufRead,BufNewFile *.js setfiletype javascript.jsx
autocmd BufRead,BufNewFile *.rs setfiletype rust

nnoremap s <Nop>
nnoremap st :<C-u>tabnew<CR>
nnoremap s= <C-w>=
nnoremap sv :sv<CR>
nnoremap vs :vs<CR>
nnoremap sw <C-w>w

filetype plugin indent on
set tabstop=2 shiftwidth=2 autoindent expandtab number

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

  if has('nvim')
      call dein#add('Shougo/deoplete.nvim')
  endif

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
