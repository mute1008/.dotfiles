#!/bin/bash

if [ ! -f $HOME/.local/bin/mise ]; then
  curl https://mise.run | sh

  mise settings set python.compile false
  mise install python@3.13.0
  mise use python@3.13.0 -g

  mise install node@24.0.0
  mise use node@24.0.0 -g

  mise install go@1.24.3
  mise use go@1.24.3 -g
fi
