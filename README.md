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
- Change alt+tab to switch windows

# NVidia CUDA
- CUDA 10.1 (should be pre installed)
- CUDNN 7 (not higher)
  - [fix the symbolic links](https://stackoverflow.com/questions/49656725/importerror-libcudnn-so-7-cannot-open-shared-object-file-no-such-file-or-dire/61563579#61563579)

Ok this can be a real headache but it worked for me after running the [tensorflow GPU support script](https://www.tensorflow.org/install/gpu#ubuntu_1804_cuda_101) *and* [the system76 libraries](http://support.system76.com/articles/cuda/), in that order. It's possible that only the system76 libraries are necessary to make it work. Do this first in case you have to nuke the system.

# Python
- virtualenvwrapper
- tensorflow-gpu
- jupyter
- numpy
- sklearn
- matplotlib
- seaborn

# VS Code
- vscodevim

# Other Apps
- Spotify
