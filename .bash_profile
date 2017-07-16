if [ -z $TMUX ]; then
  if [ -z `tmux ls` ]; then
    tmux -2
  else
    tmux attach -d
  fi
  exit
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
