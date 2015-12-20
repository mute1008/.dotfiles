#emacs bind
bindkey -d
bindkey -e

#suspend invalid
stty susp undef

#auto_cd
setopt auto_cd

#autoload
autoload -U compinit
compinit

#history overlap
setopt HIST_IGNORE_DUPS

#alias
alias emacs='emacs -nw'
alias ls='ls --color'

# tmux
if [ -z $TMUX ] ; then
    if [ -z `tmux ls` ]; then
        tmux -2
    else
        tmux attach
    fi
    exit
fi

#prompt
PROMPT='[%n@%m]# '
