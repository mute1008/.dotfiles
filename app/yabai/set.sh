#!/bin/bash

source lib/bin.sh

if [ $(uname) = 'Darwin' ]; then
  safe_ln $(pwd)/app/yabai/files/yabairc ~/.yabairc;
  safe_ln $(pwd)/app/yabai/files/skhdrc ~/.skhdrc;
fi
