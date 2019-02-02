#!/bin/bash

if [ ! -e $GOPATH/bin/go-langserver ]; then
  go get -u github.com/sourcegraph/go-langserver
fi
