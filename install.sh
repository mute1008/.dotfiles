source source/alias.sh
source source/declare.sh
source source/export.sh

source lib/os.sh
source lib/package_manager.sh
source lib/symlink.sh

declare -a APPS=(
  go
  rust
  git
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
