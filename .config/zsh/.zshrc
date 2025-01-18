# load the version control info system
# https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh
autoload -Uz vcs_info
precmd() { vcs_info }

# display git branch in vcs info
zstyle ':vcs_info:git:*' formats ' (%b)'


# set prompt
setopt PROMPT_SUBST
# Breakdown:
#
# Show time in green if no error, otherwise red with errorr code in brackets
# %(?.%F{green}%*%f.%F{red}[%?] %*%f)
#
# not sure how I feel about printing error code.  it's informative but noisy.
# might drop it for simplicity & aesthetics.
#
# Show home dir in blue
# %F{blue}%~%f
#
# Show VCS info in magenta
# %F{magenta}${vcs_info_msg_0_}%f
#
# %B ... %b wrapper starts and stops boldface
PROMPT='%B%(?.%F{green}%*%f.%F{red}%*%f) %F{blue}%~%f%F{red}${vcs_info_msg_0_}%f%b '


# enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      alias dir='dir --color=auto'
      alias vdir='vdir --color=auto'
      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
  fi

# some more ls aliases
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'


# Neovim
export EDITOR=nvim
alias vim=nvim

# local path
export PATH="${PATH}:${HOME}/.local/bin"

# doom path
export PATH="${PATH}:${HOME}/.config/emacs/bin"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# gcloud
export PATH="${PATH}:/opt/google-cloud-cli/bin"

