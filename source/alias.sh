alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias ls='ls --color'
alias d='docker-compose'
alias rm='trash'

if [[ `uname` == 'Darwin' ]]; then
  alias find=gfind
  alias xargs=gxargs
fi

cd() {
    builtin cd "$@" && ls
}

ext() {
  if [ -f "$1" ] ; then
    dir_name="${1%.*}"
    mkdir -p "$dir_name" && cd "$dir_name"
    case "$1" in
      *.tar.bz2|*.tbz2) tar xjf "../$1" ;;
      *.tar.gz|*.tgz) tar xzf "../$1" ;;
      *.bz2) bunzip2 "../$1" ;;
      *.rar) unrar x "../$1" ;;
      *.gz) gunzip "../$1" ;;
      *.tar) tar xf "../$1" ;;
      *.zip) unzip "../$1" ;;
      *.Z) uncompress "../$1" ;;
      *.7z) 7z x "../$1" ;;
      *) echo "'$1' can't be extracted" && cd .. && rm -r "$dir_name" ;;
    esac
    cd ..
  else
    echo "'$1' is not a valid file"
  fi
}
