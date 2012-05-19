PROMPT='[%{$fg_bold[red]%}%n@%m%{$reset_color%}][%{$fg_bold[cyan]%}${PWD/#$HOME/~}%{$reset_color%}]$(git_prompt_info)$(virtualenv_info)[%{$fg_bold[yellow]%}%!%{$reset_color%}][%{$fg_bold[magenta]%}%?%{$reset_color%}]%{$fg_bold[red]%}>>>%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg_bold[green]%}git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

virtualenv_info()
{
    if (( ${+VIRTUAL_ENV} )); then
        echo "[%{$fg_bold[blue]%}ve:`basename ${VIRTUAL_ENV}`%{$reset_color%}]"
    fi
}

