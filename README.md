I generally stick to GNOME Debian forks. Currently I'm partial to Linux Mint.
This deprecates a lot of modifications I used to do, e.g. GNOME shell
extensions. Most of these folders should just go directly into $HOME/.config, or
$XDG_CONFIG_HOME.

### nvim
- [vim-plug](https://github.com/junegunn/vim-plug#unix-linux)
- init.vim
- `pip install neovim` to fix YCM completion
Run below:
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo source ~/dot/nvim/init.vim > .config/nvim/init.vim
```
Then open vim and run `:PlugInstall`

### git
Add the following configuration:

```
# ~/.gitconfig
[include]
    path = ~/dot/git/config
```

### VS Code
- vscodevim
- Dracula
- Jupyter
- Pylance
- Python
- Rewrap
- Docker

### Real apps

- Unity
- Obsidian

## Apps that are just electron wrappers

Install these as necessary because you can use them exactly the same in the browser.

- Spotify
- Discord
- Slack
- Todoist

## Wake-on-LAN
```
nmcli connection show
nmcli connection modify "Wired connection 1" 802-3-ethernet.wake-on-lan magic
```

## Archival

I don't generally use these tools anymore:

### Alacritty
- [Inconsolata Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/InconsolataGo/Regular/complete/InconsolataGo%20Nerd%20Font%20Complete.ttf)

### zsh
- [thefuck](https://github.com/nvbn/thefuck#installation)
- [PowerLevel10k](https://github.com/romkatv/powerlevel10k#manual)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#in-your-zshrc)

### GNOME

- [NVidia Monitor](https://extensions.gnome.org/extension/1320/nvidia-gpu-stats-tool/)
- [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
- Change alt+tab to switch windows

### NVidia CUDA

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

# Other Apps
