#!/bin/sh
# WSL only: paste the Windows clipboard into the tmux pane given as $1.
# Reads the Windows clipboard via PowerShell, strips CR and any trailing
# newline, then loads it into a dedicated buffer and pastes it.
target=${1:-}
ps=/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe

# command substitution strips trailing newlines; printf adds none back
clip=$("$ps" -NoProfile -Command "[Console]::OutputEncoding=[Text.Encoding]::UTF8; Get-Clipboard" | tr -d '\r')
printf '%s' "$clip" | tmux load-buffer -b winclip -

if [ -n "$target" ]; then
  tmux paste-buffer -d -b winclip -t "$target"
else
  tmux paste-buffer -d -b winclip
fi
