#!/bin/bash

source lib/symlink.sh
source lib/os.sh

symlink ./app/xmonad/files/xmobarrc ~/.xmonad/xmobarrc
symlink ./app/xmonad/files/xmonad.hs ~/.xmonad/xmonad.hs
if [ $(get_os) = "Linux" -a ! -e ~/.xmonad/xmonad-x86_64-linux ]; then
  $(cd ~/.xmonad && xmonad --recompile) 1>/dev/null
fi
