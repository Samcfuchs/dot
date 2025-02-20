# Dotfiles
I generally stick to GNOME Debian forks. Currently I'm partial to Linux Mint.
This deprecates a lot of modifications I used to do, e.g. GNOME shell
extensions. I no longer move all the files into `~/.config`, I prefer to add
links to these files in the native configurations.

## Apt packages

Install system packages with 

```sh
sudo apt install -y $(cat apt-packages.txt)
```

#### Docker

Installs with apt, but you need to add their repo:

<https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository>

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Before installing:

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Configuration

### nvim

I use [vim-plug](https://github.com/junegunn/vim-plug#unix-linux) to load
extensions. Create a link in .config/nvim/init.vim to load the file in this
repo. Run `pip install neovim` to fix YCM completion.

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir .config/nvim
echo "source ~/dot/nvim/init.vim" > .config/nvim/init.vim
```

Then open vim and run `:PlugInstall`

### git
Add the following configuration to `~/.gitconfig`:

```ini
[include]
    path = ~/dot/git/config
```

### Cinnamon

Install "Command Launcher" and then import the file
[command.json](cinnamon/command.json) which adds an icon to the panel which
rotates the secondary monitor. Must use proprietary Nvidia drivers for this to
work. Add further extensions to taste. The following keyboard commands are
useful:

- Super-Tab: Show the window selection screen
- Super+R: Run dialog
- Super+H: Switch to left workspace
- Super+L: Switch to right workspace
- Super+T: Launch terminal
- Super+W: Launch web browser
- Super+.: Toggle always on top
- Super+F11: Toggle fullscreen state

### VS Code
The [settings.json](Code/User/settings.json) goes in `~/.config/Code/User/`.
There's no way to reference this file from the default. You could maybe symlink
it if you really wanted to. These are all necessary extensions, but there are
more, too.

- vscodevim
- Dracula
- Rewrap
- Remote - SSH
- Remote Explorer

The rest are basically project-specific.

## Llama

Setting up a local llama is actually very easy using
[open-webui](https://github.com/open-webui/open-webui). There's a lot of
configuration to do once the server is running, however.

```bash
curl -fsSL https://ollama.com/install.sh | sh

python3 -m venv llama-env
source ./llama-env/bin/activate
pip install open-webui
open-webui serve
```

Serves at <http://localhost:8080>. The admin stuff is only a little bit more
tricky. I use cloudflared to set up a network tunnel to my PC, which is hosted
at <http://ai.samcfuchs.com>.

## Real apps

These can't be installed through a package manager, I think. Some are bundled
with operating systems by default. I generally try to avoid Flatpaks in order to
preserve storage, but some cannot be avoided.

- Unity
- Obsidian
- AppFlowy
- VS Code
- LibreOffice
- Firefox

## Apps that are just electron wrappers

Install these as necessary because you can use them exactly the same in the browser.

- Spotify
- Discord
- Slack
- Todoist

## Wake-on-LAN

Once WOL is enabled in BIOS, we just need to run the following on the target
system to enable magic packets. [wake-pc.sh](wake-pc.sh) will wake up CHRIS.

```bash
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
