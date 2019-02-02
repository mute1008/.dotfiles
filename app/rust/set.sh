#!/bin/bash

if [[ ! -e `which rustup` ]];then
  curl https://sh.rustup.rs -sSf | sh
  rustup override set stable
  rustup update
  rustup component add rls rust-analysis rust-src
fi
