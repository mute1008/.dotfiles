set hidden

" ドキュメントを表示
nnoremap <silent> <Space>i :LspImplementation<CR>

" 定義ジャンプ
nnoremap <silent> <Space>j :LspDefinition<CR>

" リネーム
nnoremap <silent> <Space>r :LspRename<CR>

" フォーマッティング
nnoremap <silent> <Space>f :LspDocumentFormatSync<CR>

if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
    autocmd BufWritePre *.go :silent LspDocumentFormatSync
endif
