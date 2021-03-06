autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "on %{$fg[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg[magenta]%}unpushed%{$reset_color%} "
  fi
}

ruby_version() {
  if (( $+commands[rbenv] ))
  then
    echo "$(rbenv version | awk '{print $1}')"
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  fi
}

node_version() {
  if [[ $(type nvm) == 'nvm is a shell function' ]]
  then
    echo "$(nvm current)"
  fi
}

py_venv() {
  if ! [[ -z  $VIRTUAL_ENV ]]
  then
    basename $VIRTUAL_ENV
  else
    echo ""
  fi
}

rb_prompt() {
  prmt=""
  if ! [[ -z "$(py_venv)" ]]; then
    prmt="${prmt}[%{$fg_bold[blue]%}$(py_venv)%{$reset_color%}]  "
  fi

  if ! [[ -z "$(ruby_version)" ]]; then
    prmt="${prmt}ruby@%{$fg[yellow]%}$(ruby_version)%{$reset_color%} "
  fi

  if ! [[ -z "$(node_version)" ]]; then
    prmt="${prmt}node@%{$fg[yellow]%}$(node_version)%{$reset_color%} "
  fi

  echo $prmt
}

directory_name() {
  echo "%{$fg[cyan]%}%1/%\/%{$reset_color%}"
}

remote_host() {
  if [[ -n "$SSH_CONNECTION" ]]
  then
    echo "%{$fg[blue]%}@$(hostname -s)%{$reset_color%} "
  else
    echo ""
  fi
}

set_prompt () {
  last_command_status=$?

  PROMPT=$'\n$(remote_host)$(rb_prompt)in $(directory_name) $(git_dirty)$(need_push)\n'

  if [[ $last_command_status == 0  ]]
  then
    PROMPT+='%{$fg[green]%}✓%{$reset_color%}'
  else
    PROMPT+='%{$fg[red]%}✗%{$reset_color%}'
  fi

  PROMPT+='› '

  export PROMPT
  export RPROMPT="%{$fg[cyan]%}%{$reset_color%}"
  
}

precmd() {
  set_prompt
  title "zsh" "%m" "%55<...<%~"
}
