
export XDG_CONFIG_HOME="$HOME/.config"

export EDITOR="nvim"
export VISUAL="nvim"
export nvimrc="$XDG_CONFIG_HOME/nvim/init.vim"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'


export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Documents
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source $HOME/.local/bin/virtualenvwrapper.sh

export PATH="/usr/local/cuda/bin:$PATH"
