source ~/keys.env

alias la="ls -la"
MYVIMRC=~/dot/nvim/init.vim
alias vim=nvim
alias ..="cd .."
#alias /="cd /"

take() {
  mkdir -p $1
  cd $1
}

export STARSHIP_CONFIG=~/dot/starship/config.toml

#eval "$(starship init bash)"


if [ -z "$FBTERM" ] && [ "$(tty)" = "/dev/tty1" ]; then
#    exec fbterm -s 35 -- bash -c 'TERM=fbterm tmux'
#    exec fbterm -s 35 -- bash -c 'TERM=fbterm tmux new-session -d "btop; exec bash" && tmux attach'
    exec fbterm -s 35 -- bash -c 'export TERM=fbterm && tmux new-session -d "btop; exec bash" && tmux attach'
    #export TERM=fbterm
fi

eval $(thefuck --alias)
#eval $(thefuck --alias fuck)

