# alias
# --------------------------------
alias vim='nvim `find .`'
alias vi='nvim `find .`'
alias ls='ls --color'
if [ `uname` == 'Darwin' ]; then
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
	alias find=gfind
	alias xargs=gxargs
fi

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

# pyenv
# --------------------------------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# --------------------------------

# fzf
# --------------------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# --------------------------------

# functions
# --------------------------------
gtags () {
  version=`pyenv global`
  pyenv global 2.7.13
  `which gtags` ${1}
  pyenv global 3.6.1
}

find () {
  `which find` ${*} 2>/dev/null | fzf
}

git_preview() {
  git diff --color ${*} 1>/dev/null 2>/dev/null

  # git diffに失敗 -> 
  #   delete this file
  if [[ $? -ne 0 ]]; then
    echo "delete this file"
    return 0
  fi
  
  # ファイルが存在するかつ, ステージングに上がっていない
  git ls-files --others --exclude-standard | xargs echo | grep "${*}" 1>/dev/null 2>/dev/null
  if [[ $? -eq 0 ]]; then
    pyenv global 2.7.13 && pygmentize -O style=monokai -f console256 -O encoding=utf-8 -g ${*} && pyenv global 3.6.1
    return 0
  fi

  # ステージングに上がっているファイル
  git diff --name-only --cached | xargs echo | grep "${*}"
  if [[ $? -eq 0 ]]; then
    git diff --color --cached ${*}
  fi

  # 上記以外
  git diff --color ${*}
}

g () {
  if [ "checkout" == ${1} ]; then
    git ${*} `git branch --all | fzf | sed "s/remotes\/origin\///g" | sed "s/ //g"` 2>/dev/null 1>/dev/null
    echo -n "Your branch is up-to-date with"

    branch=`git rev-parse --abbrev-ref @`
    echo -e '\e[33m '$branch' \e[m'

    return 0
  elif [ "status" == ${1} ]; then
    #staged files
    # modified files
    # untracking files
    while gitfiles=`git diff --name-only --cached | xargs -n1 -I{} echo -e "\e[32m{}\e[m" &&
                    git diff --name-only | xargs -n1 -I{} echo -e "\e[31m{}\e[m" &&
                    git ls-files --others --exclude-standard | xargs -n1 -I{} echo -e "\e[31m{}\e[m"` &&
          out=`echo -e $gitfiles | xargs -n1 echo -e |
          fzf --expect=ctrl-c,ctrl-a,enter --ansi --preview 'source ~/.bash_profile && git_preview {}'`; do

      body=`echo $out | sed -e "s/.* //g"`
      if [[ `echo $out | grep ctrl-c` ]]; then
        return 0
      elif [[ `echo $out | grep ctrl-a` ]];then
        git add $body
        continue
      fi

      git diff --color $body | less -R
    done
  fi

  git ${*}
}
# --------------------------------
