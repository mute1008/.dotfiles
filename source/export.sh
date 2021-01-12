# general
export EDITOR=nvim
export PATH=~/.local/bin:$PATH

# python
export PYTHON2=2.7.18
export PYTHON3=3.8.2

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/1.15.2/bin

# gcloud
export PATH=${0:A:h}/bin:$PATH

# scripts
export PATH=~/.scripts/:$PATH

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"

# for binary
export PATH="$HOME/.userbin/:$PATH"

# gem
export PATH="$HOME/.gem/ruby/2.7.0/bin/:$PATH"

# yakumo
export PATH="$HOME/yakumo/tools/yakumo:$PATH"

# Darwin
if [[ `uname` == 'Darwin' ]]; then
  coreutils_path="/usr/local/opt/coreutils"
  export JAVA_HOME=$(/usr/libexec/java_home -v 11)
  export PATH=$coreutils_path/libexec/gnubin:$PATH
  export PATH="/usr/local/opt/mysql-client/bin:$PATH"
  export INSTALL_PACKAGE="brew install"
  source <(kubectl completion zsh)
fi

# Linux
if [[ `uname` == 'Linux' ]]; then
  export INSTALL_PACKAGE="sudo pacman -S --noconfirm"
fi
