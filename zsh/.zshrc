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
export FZF_DEFAULT_OPTS="--height=20 --border --layout=reverse"
export zshrc=$HOME/.zshrc
export caddyfile=$HOME/caddy/Caddyfile

# Aliases
take() {
  mkdir -p $1
  cd $1
}

# mvln ~/obsidian ~/dot/docker/obsidian
mvln() {
    cp $1 $2 -r
    #mv $1 $1~
    ln -svbnf $2 $1
}

alias nvim="~/Apps/nvim-linux-x86_64.appimage"

alias workoff=deactivate
alias ls="ls --color=auto"
alias x=exit
alias la="ls -lA --color=auto"
alias ..="cd .."
alias vim=nvim
alias /="cd /"
alias epoch="date -u +%s"
alias fzf='fzf --border-label="fzf $(pwd)"'
alias vf="vim \$(fzf)"
#alias dps="docker ps --format  'table {{.Names}} [{{.Image}}]\t{{.State}} - ({{.Status}})'"
alias dps="docker ps --format  'table {{.Names}}\t{{.State}} - ({{.Status}})\t{{.Networks}}'"

dni() {
  docker network inspect $1 | jq '.[0].Containers | [.[] | {name:.Name, ip:.IPv4Address, mac:.MacAddress}]' \
  | jq -r '.[] | [.name, .ip, .mac] | @tsv' | column -t -C name='CONTAINER NAME' -C name="IP" -C name="MAC ADDRESS"
}

# Autocomplete vim keys
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

export EDITOR=$HOME/Apps/nvim-linux-x86_64.appimage
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Thefuck
#eval $(thefuck --alias)

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
#[[ ! -f $XDG_CONFIG_HOME/zsh/.p10k.zsh ]] || source $XDG_CONFIG_HOME/zsh/.p10k.zsh
[[ ! -f ~/dot/zsh/.p10k.zsh ]] || source ~/dot/zsh/.p10k.zsh

source ~/dot/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dot/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/usr/local/cuda/bin:$PATH"
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
export PATH="$HOME/dot/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/yabridge:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/sam/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/sam/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/sam/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/sam/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# add Pulumi to the PATH
export PATH=$PATH:/home/sam/.pulumi/bin
