set hidden
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
   \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
   \ 'python': ['pyls'],
   \ 'c': ['clangd'],
   \ 'cpp': ['clangd'],
   \ 'go': ['$GOPATH/bin/go-langserver', '-format-tool', 'gofmt', '-lint-tool', 'golint', '-diagnostics'],
   \ }

" ドキュメントを表示
nnoremap <silent> sd :call LanguageClient#textDocument_hover()<CR>

" 定義ジャンプ
nnoremap <silent> sj :call LanguageClient#textDocument_definition()<CR>

" リネーム
nnoremap <silent> sr :call LanguageClient#textDocument_rename()<CR>

" 参照場所
nnoremap <silent> sl :Denite references -mode=normal<CR>
