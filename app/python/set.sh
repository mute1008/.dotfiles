#!/bin/bash

if [ ! -e ~/.pyenv ];then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  eval "$(pyenv init -)"
fi

if [ ! "`pyenv versions | grep $PYVERSION2`" ];then
  pyenv install $PYVERSION2;
fi

if [ ! "`pyenv versions | grep $PYVERSION3`" ];then
  pyenv install $PYVERSION3;
fi

pyenv global $PYVERSION3
pip install --upgrade pip > /dev/null

if [ ! "`pip freeze | grep pynvim`" ];then
  pip install pynvim;
fi

if [ ! "`pip freeze | grep neovim`" ];then
  pip install neovim;
fi

if [ ! "`pip freeze | grep python-language-server`" ];then
  pip install python-language-server
  pip install 'python-language-server[pycodestyle]'
  pip install 'python-language-server[yapf]'
fi
