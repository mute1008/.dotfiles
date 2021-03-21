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
  # desktop
  ["sway"]="sway"
  ["waybar"]="waybar"
  ["alacritty"]="alacritty"
  ["rofi"]="rofi"
  ["fcitx fcitx-mozc fcitx-configtool"]="fcitx"

  # utils
  ["which"]="which"
  ["neovim"]="nvim"
  ["gcc"]="gcc"
  ["make"]="make"
  ["the_silver_searcher"]="ag"
  ["xclip"]="xclip"
  ["netcat"]="nc"
  ["openssh"]="ssh"

  # audio
  ["xbindkeys"]="xbindkeys"
  ["alsa-utils"]="alsamixer"
  ["pulseaudio"]="pulseaudio"
  ["pavucontrol"]="pavucontrol"
)

declare -A DARWIN_APPS=(
  # tmux copy plugin
  ["reattach-to-user-namespace"]="reattach-to-user-namespace"

  # GNU Apps
  ["coreutils"]="gcat"
  ["binutils"]="/usr/local/opt/binutils/bin/gar"
  ["findutils"]="gfind"
)
