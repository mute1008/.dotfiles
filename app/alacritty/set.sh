#!/bin/bash

source lib/bin.sh

if [ $(uname) = 'Darwin' ]; then
  safe_ln $(pwd)/app/alacritty/files/alacritty_macos.yml ~/.config/alacritty/alacritty.yml;
elif [ $(uname) = 'Linux' ]; then
  safe_ln $(pwd)/app/alacritty/files/alacritty_linux.yml ~/.config/alacritty/alacritty.yml;
fi
