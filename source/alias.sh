alias vim='nvim'
alias vi='nvim'
alias ls='ls --color'
alias d='docker-compose'
alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'
alias st='stern'

if [[ `uname` == 'Darwin' ]]; then
  alias find=gfind
  alias xargs=gxargs
  alias copy=pbcopy
  alias paste=pbpaste
fi

if [[ `uname` == 'Linux' ]]; then
  alias copy='xsel --clipboard --input'
  alias paste='xsel --clipboard --output'
fi
