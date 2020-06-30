#!/bin/bash

if [[ ! -e `which rustup` ]];then
  yes 1 | curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  ~/.cargo/bin/rustup override set stable
  ~/.cargo/bin/rustup update
  ~/.cargo/bin/rustup component add rls rust-analysis rust-src
fi
