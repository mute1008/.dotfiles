let g:NERDTreeHighlightCursorline = 1
let g:nerdtree_sync_cursorline = 1

map <C-n> :NERDTreeToggle<CR>
autocmd BufWinEnter * NERDTreeMirror
