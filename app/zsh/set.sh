#!/bin/bash

source lib/bin.sh

[ ! -d ~/.oh-my-zsh ] && \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
safe_ln $(pwd)/app/zsh/files/zshrc ~/.zshrc
