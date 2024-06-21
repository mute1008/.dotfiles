#!/bin/bash

source source/lib.sh

git config --global user.name mute1997
git config --global user.email mute1008@gmail.com
git config --global core.excludesfile $(pwd)/app/git/files/gitignore

mkdir -p ~/.userbin/
safe_ln $(pwd)/app/git/files/git-fpull ~/.userbin/git-fpull
safe_ln $(pwd)/app/git/files/gitconfig ~/.gitconfig
