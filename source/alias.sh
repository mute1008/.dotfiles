alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias ls='ls --color'
alias l='ls --color'
alias d='docker-compose'

alias rm='trash'
alias empty='trash-empty'
alias restore='trash-restore'
alias list='trash-list'

if [[ `uname` == 'Darwin' ]]; then
  alias find=gfind
  alias xargs=gxargs
fi

cd() {
    builtin cd "$@" && ls
}
