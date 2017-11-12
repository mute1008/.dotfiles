export PYVERSION2=2.7.13
export PYVERSION3=3.6.1
export EDITOR=nvim
export PATH="$HOME/.cargo/bin:$PATH"

# prompt
# --------------------------------
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
source ~/.git-prompt.sh
# --------------------------------

# alias
# --------------------------------
alias vim='pyenv global $PYVERSION3 && nvim'
alias vi='nvim'
alias ls='ls --color'
# --------------------------------

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

# Mac setting
# --------------------------------
# $(brew --prefix coreutils)が遅いため文字列として埋め込む
if [ `uname` == 'Darwin' ]; then
  coreutils_path="/usr/local/opt/coreutils"
  export PATH=$coreutils_path/libexec/gnubin:$PATH
  alias find=gfind
  alias xargs=gxargs
fi
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
