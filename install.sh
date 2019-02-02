#!/bin/bash

source source/alias.sh
source source/declare.sh
source source/export.sh

source lib/os.sh
source lib/package_manager.sh
source lib/symlink.sh

install_dependencies
ls app | xargs -n1 -I{} bash ./app/{}/set.sh
