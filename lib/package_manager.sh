source lib/os.sh

# $1 = install package name
# $2 = command name
function install_if_not_exists_cmd() {
  if [[ ! -e `which $2` ]]; then
    $INSTALL_PACKAGE $1
  fi
}

function install_dependencies() {
  echo -e "\e[34m ========== Start to install dependencies ========== \e[m"
  for KEY in ${!GENERAL_APPS[@]}; do
    echo -e "\e[32m ========== install ${KEY} ========== \e[m"
    install_if_not_exists_cmd $KEY ${GENERAL_APPS[$KEY]}
      if [ $? -ne 0 ]; then
        exit 1
      fi
  done

  echo -e "\e[34m ========== Start to install dependencies for MacOS ========== \e[m"
  if [ $(get_os) = 'Darwin' ]; then
    for KEY in ${!DARWIN_APPS[@]}; do
      echo -e "\e[32m ========== install ${KEY} ========== \e[m"
      install_if_not_exists_cmd $KEY ${DARWIN_APPS[$KEY]}
      if [ $? -ne 0 ]; then
        exit 1
      fi
    done
  fi

  echo -e "\e[34m ========== Start to install dependencies for Linux ========== \e[m"
  if [ $(get_os) = 'Linux' ]; then
    for KEY in ${!LINUX_APPS[@]}; do
      echo -e "\e[32m ========== install ${KEY} ========== \e[m"
      install_if_not_exists_cmd $KEY ${LINUX_APPS[$KEY]}
      if [ $? -ne 0 ]; then
        exit 1
      fi
    done
  fi
}

function install() {
   echo -e "\e[34m ========== Start to install Apps ========== \e[m"
  for app in ${APPS[@]}; do
    echo -e "\e[32m ========== Start to install $app ========== \e[m"
    bash ./app/$app/set.sh
    if [ $? -ne 0 ]; then
      echo -e "\e[31m ========== Failed to install $app ========== \e[m"
      exit
    fi
  done
}
