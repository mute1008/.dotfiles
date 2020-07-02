#!/bin/bash

mkdir -p $HOME/.userbin

[ ! -d $HOME/.userbin/direnv ] && exit 0

if [ $(uname) = "Linux" ]; then
  curl -L https://github.com/direnv/direnv/releases/download/v2.21.3/direnv.linux-amd64 -o $HOME/.userbin/direnv
elif [ $(uname) = "Darwin" ]; then
  curl -L https://github.com/direnv/direnv/releases/download/v2.21.3/direnv.darwin-amd64 -o $HOME/.userbin/direnv
fi

chmod +x $HOME/.userbin/direnv
