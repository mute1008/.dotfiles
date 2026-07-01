#!/bin/bash

source source/lib.sh

git config --global user.name mute1997
git config --global user.email mute1008@gmail.com
# pull.rebase 等の設定は gitconfig 本体へ集約済み
safe_ln $(pwd)/app/git/files/gitconfig ~/.gitconfig
