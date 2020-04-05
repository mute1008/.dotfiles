#!/bin/bash

if [[ ! -e `which rustup` ]];then
  curl https://sh.rustup.rs -sSf | sh
  ~/.cargo/bin/rustup override set stable
  ~/.cargo/bin/rustup update
  ~/.cargo/bin/rustup component add rls rust-analysis rust-src
fi
