#!/bin/bash

source lib/symlink.sh
source lib/os.sh

if [ $(get_os) = 'Darwin' ]; then
  symlink ./app/karabiner/files/linux-style.json ~/.config/karabiner/assets/complex_modifications/linux-style.json;
fi
