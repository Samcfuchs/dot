# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#echo "my zshrc loaded"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/dot/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Documents
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#source $HOME/.local/bin/virtualenvwrapper.sh

# Aliases
take() {
  mkdir -p $1
  cd $1
}

alias workoff=deactivate
alias ls="ls --color=auto"
alias x=exit
alias la="ls -lA --color=auto"
alias ..="cd .."
alias /="cd /"

# Autocomplete vim keys
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Thefuck
#eval $(thefuck --alias)

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
#[[ ! -f $XDG_CONFIG_HOME/zsh/.p10k.zsh ]] || source $XDG_CONFIG_HOME/zsh/.p10k.zsh
[[ ! -f ~/dot/zsh/.p10k.zsh ]] || source ~/dot/zsh/.p10k.zsh

source ~/dot/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dot/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
