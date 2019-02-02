#!/bin/bash

function get_os() {
  python -c "import platform;print(platform.system())"
}
