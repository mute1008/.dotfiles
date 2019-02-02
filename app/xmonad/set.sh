#!/bin/bash

source lib/symlink.sh
source lib/os.sh

if [ $(get_os) = "Linux" ]; then
  symlink ./app/xmonad/files/xmobarrc ~/.xmonad/xmobarrc
  symlink ./app/xmonad/files/xmonad.hs ~/.xmonad/xmonad.hs
  $(cd ~/.xmonad && xmonad --recompile) 1>/dev/null
fi
