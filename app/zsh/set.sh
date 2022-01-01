#!/bin/bash

source source/lib.sh

[ ! -d ~/.oh-my-zsh ] && \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
safe_ln $(pwd)/app/zsh/files/zshrc ~/.zshrc


if [ ! -d ~/.kube-ps1 ]; then
  git clone git@github.com:jonmosco/kube-ps1.git ~/.kube-ps1
fi
