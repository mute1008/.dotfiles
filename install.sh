source source/lib.sh
source source/alias.sh
source source/export.sh

declare -a APPS=(
  anyenv
  git
  zsh
  nvim
  ssh
  kube
)

echo -e "\e[34m ========== Start to install Apps ========== \e[m"
for app in ${APPS[@]}; do
  echo -e "\e[32m ========== Start to install $app ========== \e[m"
  bash ./app/$app/set.sh
  if [ $? -ne 0 ]; then
    echo -e "\e[31m ========== Failed to install $app ========== \e[m"
    exit
  fi
done
