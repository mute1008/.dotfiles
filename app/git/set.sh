#!/bin/bash

source source/lib.sh

git config --global user.name mute1997
git config --global user.email mute1008@gmail.com
git config pull.rebase true
safe_ln $(pwd)/app/git/files/gitconfig ~/.gitconfig
