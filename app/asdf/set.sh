#!/bin/bash

[ ! -d ~/.asdf ] && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
source "$HOME/.asdf/asdf.sh"

# Python
bash -c "\
  asdf plugin-add python && \
  asdf install python 2.7.18 && \
  asdf install python 3.12.0 && \
  asdf global python 3.12.0" 1>/dev/null

# Node.js
bash -c "\
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git && \
  asdf install nodejs 23.0.0 && \
  asdf global nodejs 23.0.0" 1>/dev/null

# Golang
bash -c "\
  asdf plugin add golang https://github.com/asdf-community/asdf-golang.git && \
  asdf install golang 1.23.2 && \
  asdf global golang 1.23.2" 1>/dev/null

# Ruby
bash -c "\
  asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git && \
  asdf install ruby 3.3.5 && \
  asdf global ruby 3.3.5" 1>/dev/null
