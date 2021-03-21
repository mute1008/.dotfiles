source source/alias.sh
source source/apps.sh
source source/export.sh

source lib/sbin.sh

declare -a APPS=(
  anyenv
  git
  zsh
  tmux
  nvim
  ssh
  alacritty
  sway
)

install_dependencies
install
