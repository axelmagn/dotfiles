# run in all interactive shells

# set up convenient interactive settings
autoload -U compinit promptinit -U colors && colors
compinit
promptinit
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt inc_append_history
setopt share_history
setopt extended_history
setopt prompt_subst

# use emacs editing mode
set -o emacs

# useful aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias sudo='sudo -E'
alias l='ls -Alsh' ll='ls -l' la='ls -a'

# set up a git-aware prompt
prompt_char() {
    branch=`git branch 2> /dev/null | grep \* | awk '{print $2}'`
    if [ ${branch} ]; then
        gp="[%{$fg[magenta]%}${branch}"
        if [ `git status --porcelain 2> /dev/null | wc -l` -ne 0 ]; then
            gp="${gp}%{$reset_color%}(%{$fg[green]%}ϟ%{$reset_color%})"
        fi
        gp="${gp}%{$reset_color%}]±"
        echo ${gp}
        return
    fi
    echo "%%"
}
PROMPT="%{$fg[blue]%}%B%n%{$fg[red]%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[blue]%}%B%1~%{$reset_color%}%b\$(prompt_char) "
PS1="${PROMPT}"
rprompt_precmd() {
    if [ $? -ne 0 ]; then
        RPROMPT="(%{$fg[red]%}%?%{$reset_color%})"
    else
        RPROMPT=""
    fi
}
precmd_functions+=(rprompt_precmd)

# source scripts from .rc.d directory
for i in ${HOME}/.rc.d/*.sh ; do
    if [ -r "$i" ]; then
         if [ "${-#*i}" != "$-" ]; then
            source "$i"
        else
            source "$i" >/dev/null 2>&1
        fi
    fi
done
unset i
