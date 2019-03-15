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
  for KEY in ${!GENERAL_APPS[@]}; do
    install_if_not_exists_cmd $KEY ${GENERAL_APPS[$KEY]}
  done

  if [ $(get_os) = 'Darwin' ]; then
    for KEY in ${!DARWIN_APPS[@]}; do
      install_if_not_exists_cmd $KEY ${DARWIN_APPS[$KEY]}
    done
  fi

  if [ $(get_os) = 'Linux' ]; then
    for KEY in ${!LINUX_APPS[@]}; do
      install_if_not_exists_cmd $KEY ${LINUX_APPS[$KEY]}
    done
  fi
}
