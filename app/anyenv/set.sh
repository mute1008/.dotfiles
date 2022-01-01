#!/bin/bash

[ ! -d ~/.anyenv ] && git clone https://github.com/anyenv/anyenv ~/.anyenv
export PATH="$HOME/.anyenv/bin:$PATH"

anyenv_root=$(anyenv root)
mkdir -p $anyenv_root/plugins
[ ! -d $anyenv_root/plugins/anyenv-lazyload ] && \
  git clone https://github.com/amashigeseiji/anyenv-lazyload.git $anyenv_root/plugins/anyenv-lazyload

[ ! -d ~/.config/anyenv/anyenv-install ] && yes | anyenv install --init
yes no | anyenv install pyenv > /dev/null
yes no | anyenv install goenv > /dev/null
eval "$(anyenv init -)"

pyenv_root=$(pyenv root)
[ ! -d $pyenv_root/plugins/pyenv-virtualenv ] && \
  git clone https://github.com/pyenv/pyenv-virtualenv.git $pyenv_root/plugins/pyenv-virtualenv
eval "$(anyenv init -)"
