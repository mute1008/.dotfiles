#!/bin/bash

source source/lib.sh

if [ -d "/mnt/c/Users" ]; then
  username=$(whoami.exe | cut -d "\\" -f2 | tr -d "\\r")
  cp $(pwd)/app/glazewm/files/config.yaml /mnt/c/Users/${username}/.glzr/glazewm/config.yaml
  cp $(pwd)/app/glazewm/files/zebar/* /mnt/c/Users/${username}/.glzr/zebar/starter/
  glazewm.exe command wm-reload-config > /dev/null
fi
