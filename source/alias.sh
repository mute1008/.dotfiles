alias vim='nvim'
alias vi='nvim'
alias ls='ls --color'
alias d='docker-compose'
alias k='kubectl'
alias rm='trash'

if [[ `uname` == 'Darwin' ]]; then
  alias find=gfind
  alias xargs=gxargs
fi
