source source/lib.sh
source source/alias.sh
source source/export.sh

declare -a APPS=(
  # Dev
  mise
  git
  zsh
  ssh

  # Editor
  nvim
  intellij

  # WM
  aerospace
  glazewm
)

printf "\e[34m ========== Start to install Apps ========== \e[m\n"
for app in ${APPS[@]}; do
  printf "\e[32m ========== Start to install $app ========== \e[m\n"
  bash ./app/$app/set.sh
  if [ $? -ne 0 ]; then
    printf "\e[31m ========== Failed to install $app ========== \e[m\n"
    exit
  fi
done
