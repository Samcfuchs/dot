Most of these folders should just go directly into $HOME/.config, or $XDG_CONFIG_HOME

# Alacritty
- [Inconsolata Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/InconsolataGo/Regular/complete/InconsolataGo%20Nerd%20Font%20Complete.ttf)

# zsh
- [thefuck](https://github.com/nvbn/thefuck#installation)
- [PowerLevel10k](https://github.com/romkatv/powerlevel10k#manual)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#in-your-zshrc)

# nvim
- [vim-plug](https://github.com/junegunn/vim-plug#unix-linux)
- init.vim
- `pip install neovim` to fix YCM completion

# GNOME

- [NVidia Monitor](https://extensions.gnome.org/extension/1320/nvidia-gpu-stats-tool/)
- [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
- Change alt+tab to switch windows

# NVidia CUDA

- CUDA 10.1 (should be pre installed)
- CUDNN 7.6 (not higher)

[Use the system76 libraries](http://support.system76.com/articles/cuda/) and
make sure you install the 10.1 versions. System76 installs these into
`/usr/lib/cuda` but tensorflow still finds them I think.

```
sudo apt install system76-cuda-10.1
sudo apt install system76-cudnn-10.1
```

[You might need to fix the symbolic links](https://stackoverflow.com/questions/49656725/importerror-libcudnn-so-7-cannot-open-shared-object-file-no-such-file-or-dire/61563579#61563579)

# Python

Use [miniconda](https://docs.anaconda.com/miniconda/) to avoid bloat but for easy environment management

- tensorflow
- pytorch
- jupyter
- numpy
- sklearn
- matplotlib
- seaborn

# VS Code
- vscodevim
- Dracula

# Other Apps

## Real apps

- Unity
- Obsidian

## Apps that are just electron wrappers

Install these as necessary because you can use them exactly the same in the browser.

- Spotify
- Discord
- Slack
- Todoist
