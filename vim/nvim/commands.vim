function s:terminal(...)
  split | resize 6 | terminal
  call feedkeys("\<C-\>")
  call feedkeys("\<C-n>")
  call feedkeys("\<C-w>w")
endfunction

command! -nargs=0 T call s:terminal()
