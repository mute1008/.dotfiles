#!/bin/bash

function absolute_path() {
  python -c "from pathlib import Path;print(Path('$1').resolve())"
}

# $1 = from
# $2 = to
function symlink() {
  # backup
  mkdir -p ~/.backup-dotfiles
  if [ -e $2 ]; then mv $2 ~/.backup-dotfiles; fi

  # create to directory
  mkdir -p $(python -c "import os;print(os.path.split('$2')[0])")

  # create symlink
  ln -s $(absolute_path $1) $2
}
