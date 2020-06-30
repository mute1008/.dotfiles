#!/bin/bash

source lib/bin.sh

if [ $(uname) = 'Darwin' ]; then
  safe_ln $(pwd)/app/karabiner/files/linux-style.json ~/.config/karabiner/assets/complex_modifications/linux-style.json
fi
