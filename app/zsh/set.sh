#!/bin/bash

source lib/symlink.sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null
symlink ./app/zsh/files/zshrc ~/.zshrc
