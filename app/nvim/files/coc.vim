" これ別タブで開くように修正したい
nmap <silent> <Space>j <Plug>(coc-definition)
nmap <silent> <Space>r <Plug>(coc-rename)
nmap <silent> <Space>a <Plug>(coc-references)
nmap <silent> <Space>f  <Plug>(coc-fix-current)
nmap <silent> <Space><Space> :call CocAction('doHover')<CR>

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <silent> sf :CocList files<CR>
nnoremap <silent> sg :CocList grep<CR>
nnoremap <silent> ss  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>

nnoremap <silent> <C-f>  :Format<CR> :w<CR>

" 補完をEnterで確定させる
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
