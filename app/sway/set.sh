#!/bin/bash

source lib/symlink.sh

if [ $(get_os) = "Linux"]; then
  symlink ./app/sway/files/confiq ~/.config/sway/config;
fi
