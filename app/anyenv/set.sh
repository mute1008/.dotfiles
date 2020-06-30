#!/bin/bash

[ ! -d ~/.anyenv ] && git clone https://github.com/anyenv/anyenv ~/.anyenv
export PATH="$HOME/.anyenv/bin:$PATH"

mkdir -p $(anyenv root)/plugins
[ ! -d $(anyenv root)/plugins/anyenv-lazyload ] && \
  git clone https://github.com/amashigeseiji/anyenv-lazyload.git $(anyenv root)/plugins/anyenv-lazyload

[ ! -d /root/.config/anyenv/anyenv-install ] && yes | anyenv install --init
yes no | anyenv install pyenv > /dev/null
yes no | anyenv install goenv > /dev/null
eval "$(anyenv init -)"

[ ! -d $(pyenv root)/plugins/pyenv-virtualenv ] && \
  git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
eval "$(anyenv init -)"

pyenv versions | grep 3.8.0 > /dev/null
[ $? = 0 ] && exit 0

pyenv install 3.8.0
pyenv virtualenv 3.8.0 nvim
pyenv activate nvim
pip install neovim
pyenv deactivate nvim
