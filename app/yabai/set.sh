#!/bin/bash

source lib/symlink.sh
source lib/os.sh

if [ $(get_os) = 'Darwin' ]; then
  symlink ./app/yabai/files/yabairc ~/.yabairc;
  symlink ./app/yabai/files/skhdrc ~/.skhdrc;
fi
