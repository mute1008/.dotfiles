declare -A GENERAL_APPS;
declare -A LINUX_APPS;
declare -A DARWIN_APPS;

declare -A GENERAL_APPS=(
  ["git"]="git"
  ["tmux"]="tmux"
  ["zsh"]="zsh"
  ["jq"]="jq"
)

declare -A LINUX_APPS=(
  ["sway"]="sway"
  ["waybar"]="waybar"
  ["alacritty"]="alacritty"
  ["which"]="which"
  ["neovim"]="nvim"
  ["gcc"]="gcc"
  ["make"]="make"
)

declare -A DARWIN_APPS=(
  # tmux copy plugin
  ["reattach-to-user-namespace"]="reattach-to-user-namespace"

  # GNU Apps
  ["coreutils"]="gcat"
  ["binutils"]="/usr/local/opt/binutils/bin/gar"
  ["findutils"]="gfind"

  # Kubernetes
  ["kubectl"]="kubectl"
  ["kubectx"]="kubectx"
)
