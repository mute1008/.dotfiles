export PYVERSION2=2.7.13
export PYVERSION3=3.6.1
export EDITOR=nvim

# prompt
# --------------------------------
export PS1="[\u@\h \W]\$ "
# --------------------------------

# alias
# --------------------------------
alias vim='pyenv global $PYVERSION3 && nvim'
alias vi='nvim'
alias ls='ls --color'
if [ `uname` == 'Darwin' ]; then
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
	alias find=gfind
	alias xargs=gxargs
fi
# --------------------------------

# tmux
# --------------------------------
if [ -z $TMUX ]; then
  if [ -z `tmux ls` ]; then
    tmux -2
  else
    tmux attach -d
  fi
  exit
fi
# --------------------------------

# 
# pyenv
# --------------------------------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# --------------------------------
# 
# fzf
# --------------------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# --------------------------------

# functions
# --------------------------------
gtags () {
  version=`pyenv global`
  pyenv global $PYVERSION2
  `which gtags` ${1}
  pyenv global $PYVERSION3
}

find () {
  `which find` ${*} 2>/dev/null
}
# --------------------------------
