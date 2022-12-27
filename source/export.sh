# general
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

# python
export PYTHON2=2.7.18
export PYTHON3=3.9.5

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# golang
export PATH="$PATH:$GOPATH/bin"

# gcloud
export PATH="${0:A:h}/bin:$PATH"

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"

# kube
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# for M1 Mac
export DOCKER_DEFAULT_PLATFORM=linux/amd64
