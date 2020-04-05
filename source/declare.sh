declare -A GENERAL_APPS;
declare -A LINUX_APPS;
declare -A DARWIN_APPS;

declare -A GENERAL_APPS=(
  ["the_silver_searcher"]="ag"
  ["git"]="git"
  ["tmux"]="tmux"
  ["zsh"]="zsh"
  ["go"]="go"
)

declare -A LINUX_APPS=(
  ["xmonad"]="xmonad"
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
