#!/usr/bin/env bash

set -euo pipefail

resurrect_dir="${TMUX_RESURRECT_DIR:-$HOME/.tmux/resurrect}"
upstream_restore="$HOME/.nix-profile/share/tmux-plugins/resurrect/scripts/restore.sh"
last_file="$resurrect_dir/last"

mkdir -p "$resurrect_dir"
exec 9>"$resurrect_dir/.save.lock"
flock -x 9

if [[ ! -e "$last_file" ]]; then
  latest="$({
    find "$resurrect_dir" -maxdepth 1 -type f \
      -name 'tmux_resurrect_*.txt' -printf '%T@\t%f\n'
  } | sort -nr | sed -n '1s/^[^\t]*\t//p')"

  if [[ -n "$latest" ]]; then
    ln -sfn -- "$latest" "$last_file"
  fi
fi

if [[ ! -e "$last_file" ]]; then
  printf 'tmux-resurrect: no valid snapshot is available\n' >&2
  exit 1
fi

exec "$upstream_restore" "$@"
