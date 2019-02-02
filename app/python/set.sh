#!/bin/bash

if [[ ! -e `which pyenv` ]];then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv

  eval "$(pyenv init -)"

  pyenv install $PYVERSION2
  pyenv install $PYVERSION3
  pyenv global $PYVERSION3

  pip install --upgrade pip

  pip install neovim
  pip install pynvim

  pip install python-language-server
  pip install 'python-language-server[pycodestyle]'
  pip install 'python-language-server[yapf]'
fi
