#!/bin/bash

source lib/symlink.sh
source lib/os.sh

if [ $(get_os) = 'Darwin' ]; then
  symlink ./app/alacritty/files/alacritty_macos.yml ~/.config/alacritty/alacritty.yml
elif [ $(get_os) = 'Linux' ]; then
  symlink ./app/alacritty/files/alacritty_linux.yml ~/.config/alacritty/alacritty.yml
fi
