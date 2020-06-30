#!/bin/bash

source lib/bin.sh

if [ $(uname) = 'Linux' ]; then
  safe_ln $(pwd)/app/sway/files/config ~/.config/sway/config;
fi
