set hidden
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
   \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
   \ 'python': ['pyls'],
   \ 'c': ['clangd'],
   \ 'cpp': ['clangd'],
   \ 'go': ['$GOPATH/bin/go-langserver', '-format-tool', 'gofmt', '-lint-tool', 'golint', '-diagnostics'],
   \ }
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
