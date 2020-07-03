set hidden

nnoremap <silent> <Space>i :LspCodeAction<CR>
nnoremap <silent> <Space>j :tab LspDefinition<CR>
nnoremap <silent> <Space>r :LspRename<CR>
nnoremap <silent> <Space>f :LspDocumentFormatSync<CR>
nnoremap <silent> <Space><Space> :LspHover<CR>
nnoremap <silent> <Space>s :call lsp#activate()<CR>
