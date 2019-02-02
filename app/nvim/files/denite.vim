call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])

nnoremap <silent>sf :Denite file_rec<CR>
nnoremap <silent>sg :Denite grep -mode=normal<CR>
nnoremap <silent>sy :Denite neoyank -mode=normal<CR>
nnoremap <silent>sb :Denite buffer -mode=normal<CR>
