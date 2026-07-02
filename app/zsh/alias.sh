# editor
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# ls
alias ls='ls --color'
alias lls='ls --color'
alias l='ls --color'

# docker-compose
alias d='docker-compose'

# trash
alias rm='trash'
alias empty='trash-empty'
alias restore='trash-restore'
alias list='trash-list'

cd() {
    builtin cd "$@" && ls
}
