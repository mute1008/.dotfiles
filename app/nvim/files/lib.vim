function! MaximumWindow(key)
  call execute(":wincmd ".a:key)

  if 1 == winheight(0)
    if a:key == "j" || a:key == "k"
      call feedkeys("\<C-w>_")
    else
      call feedkeys("\<C-w>|")
    endif
  endif
endfunction
