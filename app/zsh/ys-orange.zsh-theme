# Based on ys theme with orange accents (no oh-my-zsh dependency)

autoload -U colors && colors
setopt PROMPT_SUBST

_git_prompt_info() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  local dirty
  [[ -n $(git status --porcelain 2>/dev/null) ]] && dirty=" %{$fg[red]%}x" || dirty=" %{$fg[green]%}o"
  echo " %{$reset_color%}on%{$fg[blue]%} git%{$fg[cyan]%}:$branch$dirty%{$reset_color%}"
}

local git_info='$(_git_prompt_info)'
local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

PROMPT="
%F{208}%B#%b%f \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%F{215}%n%f) \
%{$reset_color%}in \
%F{208}%B%~%b%f\
${git_info}\
 \
[%*] $exit_code
%F{208}%B\$%b%f "
