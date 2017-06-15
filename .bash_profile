alias ls='ls -G'
alias vim='nvim'
alias ls='ls --color'

if [ -z $TMUX ]; then
  if [ -z `tmux ls` ]; then
    tmux -2
  else
    tmux attach -d
  fi
  exit
fi
