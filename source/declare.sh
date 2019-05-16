declare -A GENERAL_APPS;
declare -A LINUX_APPS;
declare -A DARWIN_APPS;

GENERAL_APPS=(
  ["the_silver_searcher"]="ag"
  ["ranger"]="ranger"
  ["alacritty"]="alacritty"
  ["git"]="git"
  ["tmux"]="tmux"
  ["zsh"]="zsh"
  ["tig"]="tig"
)

LINUX_APPS=(
  ["xmonad"]="xmonad"
)

DARWIN_APPS=(
  ["reattach-to-user-namespace"]="reattach-to-user-namespace"
  ["coreutils"]="gcat"
  ["binutils"]="gar"
  ["findutils"]="gfind"
)
