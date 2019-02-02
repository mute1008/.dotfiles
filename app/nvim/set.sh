#!/bin/bash

source lib/symlink.sh

symlink ./app/nvim/files/dein.toml ~/.config/nvim/dein.toml
symlink ./app/nvim/files/dein_lazy.toml ~/.config/nvim/dein_lazy.toml
symlink ./app/nvim/files/init.vim ~/.config/nvim/init.vim
