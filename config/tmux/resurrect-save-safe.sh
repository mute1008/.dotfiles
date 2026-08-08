#!/usr/bin/env bash

set -euo pipefail

resurrect_dir="${TMUX_RESURRECT_DIR:-$HOME/.tmux/resurrect}"
upstream_save="$HOME/.nix-profile/share/tmux-plugins/resurrect/scripts/save.sh"
last_file="$resurrect_dir/last"

mkdir -p "$resurrect_dir"
exec 9>"$resurrect_dir/.save.lock"
flock -x 9

repair_last() {
  if [[ -e "$last_file" ]]; then
    return
  fi

  local latest
  latest="$({
    find "$resurrect_dir" -maxdepth 1 -type f \
      -name 'tmux_resurrect_*.txt' -printf '%T@\t%f\n'
  } | sort -nr | sed -n '1s/^[^\t]*\t//p')"

  if [[ -n "$latest" ]]; then
    ln -sfn -- "$latest" "$last_file"
  fi
}

repair_last

# tmux-resurrect names snapshots with one-second precision. If a snapshot with
# this second already exists, wait for the filename to change before saving.
while :; do
  snapshot="tmux_resurrect_$(date +%Y%m%dT%H%M%S).txt"
  if [[ ! -e "$resurrect_dir/$snapshot" ]]; then
    break
  fi
  sleep 0.05
done

"$upstream_save" "$@"
repair_last

if [[ ! -e "$last_file" ]]; then
  printf 'tmux-resurrect: no valid snapshot exists after save\n' >&2
  exit 1
fi
