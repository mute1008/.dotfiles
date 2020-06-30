source source/alias.sh
source source/apps.sh
source source/export.sh

source lib/sbin.sh

declare -a APPS=(
  anyenv
  direnv
  git
  rust
  zsh
  tmux
  nvim
  ssh
  alacritty
  sway
  yabai
  karabiner
  scripts
)

install_dependencies
install
