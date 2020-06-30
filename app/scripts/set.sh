#!/bin/bash

source lib/bin.sh

mkdir -p ~/.scripts
safe_ln $(pwd)/app/scripts/files/ ~/.scripts
