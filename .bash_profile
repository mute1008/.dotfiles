alias ls='ls -G'
alias vim='nvim'

if [ -z $TMUX ]; then
  if [ -z `tmux ls` ]; then
    echo a
    tmux -2
  else
    echo b
    tmux attach
  fi
  exit
fi
