# general
export EDITOR=nvim
export PATH=~/.local/bin:$PATH

# python
export PYVERSION2=2.7.13
export PYVERSION3=3.8-dev

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# cuda
export PATH=/opt/cuda/bin:$PATH

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# gcloud
export PATH=${0:A:h}/bin:$PATH


# Darwin
if [[ `uname` == 'Darwin' ]]; then
  coreutils_path="/usr/local/opt/coreutils"
  export PATH=$coreutils_path/libexec/gnubin:$PATH
  export INSTALL_PACKAGE="brew install"
fi

# Linux
if [[ `uname` == 'Linux' ]]; then
  export INSTALL_PACKAGE="sudo pacman -S"
fi
