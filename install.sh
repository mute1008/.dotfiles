source source/alias.sh
source source/apps.sh
source source/export.sh

source lib/sbin.sh

declare -a APPS=(
  anyenv
  git
  zsh
  nvim
  ssh
  alacritty
  sway
  custom
)

install_dependencies
install
