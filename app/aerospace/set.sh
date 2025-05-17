#!/bin/bash

source source/lib.sh

safe_ln $(pwd)/app/aerospace/files/aerospace.toml ~/.aerospace.toml
safe_ln $(pwd)/app/aerospace/files/sketchybar/ ~/.config/sketchybar
