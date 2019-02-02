#!/bin/bash

source lib/os.sh

# $1 = install package name
# $2 = command name
function install_if_not_exists_cmd() {
  if [[ ! -e `which $2` ]]; then
    $INSTALL_PACKAGE $1
  fi
}

function install_dependencies() {
  for GENERAL_APPS in ${!APP[@]}; do
    install_if_not_exists_cmd$GENERAL_APPS $APP
  done

  if [ $(get_os) = 'Darwin' ]; then
    for DARWIN_APPS in ${!APP[@]}; do
      install_if_not_exists_cmd$GENERAL_APPS $APP
    done
  fi

  if [ $(get_os) = 'Linux' ]; then
    for LINUX_APPS in ${!APP[@]}; do
      install_if_not_exists_cmd$GENERAL_APPS $APP
    done
  fi
}
