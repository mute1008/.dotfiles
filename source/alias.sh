if [ "$(ps -o comm= -p $$)" = "zsh" ]; then
  unfunction d
fi

# editor
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# ls
alias ls='ls --color'
alias l='ls --color'

# docker-compose
alias d='docker-compose'

# trash
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
