# git completion
source $HOME/.git-completion.sh

__git_ps1 () 
{ 
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf "{%s} " "${b##refs/heads/}";
    fi
}

set_prompt() {
    local OPEN="\[";
    local CLOSE="\]";
    local BGREEN="${OPEN}$(tput setaf 2 ; tput bold)${CLOSE}"
    local BBLUE="${OPEN}$(tput setaf 4 ; tput bold)${CLOSE}"
    local BRED="${OPEN}$(tput setaf 1 ; tput bold)${CLOSE}"
    local BYELLOW="${OPEN}$(tput setaf 3 ; tput bold)${CLOSE}"
    local COLOROFF="${OPEN}$(tput sgr0)${CLOSE}"
    export PS1='${debian_chroot:+($debian_chroot)}'"${BRED}"'$(__git_ps1 "{%s} ")'"${BGREEN}"'\u@\h'"${BBLUE}"' \W \$ '"${COLOROFF}"
}
set_prompt
