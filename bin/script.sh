#ln -svf $HOME/dot/* $XDG_CONFIG_HOME
#ln -svf $HOME/dot/zsh/.zshenv $HOME/.zshenv
#

ln -svf --backup ~/dot/i3/config ~/.config/i3/config
ln -svf --backup ~/dot/polybar/{config.ini,launch.sh} ~/.config/polybar/
ln -svf --backup ~/zsh/.zshrc ~/.zshrc
