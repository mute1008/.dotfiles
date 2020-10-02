#!/bin/bash

source lib/bin.sh

if [ $(uname) = 'Linux' ]; then
  safe_ln $(pwd)/app/sway/files/config ~/.config/sway/config;
  safe_ln $(pwd)/app/sway/files/laptop.conf ~/.config/sway/laptop.conf;
  safe_ln $(pwd)/app/sway/files/desktop.conf ~/.config/sway/desktop.conf;
  safe_ln $(pwd)/app/sway/files/style.css ~/.config/waybar/style.css;
  safe_ln $(pwd)/app/sway/files/waybar_config ~/.config/waybar/config;
fi
