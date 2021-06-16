# general
export EDITOR=nvim
export PATH="~/.local/bin:$PATH"

# python
export PYTHON2=2.7.18
export PYTHON3=3.9.5

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# golang
export GOPATH=$HOME/.go
export PATH="$PATH:$GOPATH/1.15.2/bin"

# gcloud
export PATH="${0:A:h}/bin:$PATH"

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"

# Darwin
if [[ `uname` == 'Darwin' ]]; then
  #export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
  #export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
  #export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
  export INSTALL_PACKAGE="brew install"
fi

# Linux
if [[ `uname` == 'Linux' ]]; then
  export INSTALL_PACKAGE="sudo pacman -S --noconfirm"
fi
