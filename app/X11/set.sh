#!/bin/bash

source lib/symlink.sh
source lib/os.sh

if [ $(get_os) = "Linux" ]; then
  symlink ./app/X11/files/Xdefaults ~/.Xdefaults
  symlink ./app/X11/files/xprofile ~/.xprofile
fi
