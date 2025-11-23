# Linux Dotfiles

A minimal, keyboard-driven Linux desktop environment using i3wm, Kitty, Zsh with Powerlevel10k, and Rofi.

## What's Included

- **i3wm** - Tiling window manager
- **Kitty** - GPU-accelerated terminal emulator
- **Zsh + Oh My Zsh** - Modern shell with plugins
- **Powerlevel10k** - Beautiful, fast shell prompt
- **Rofi** - Application launcher with custom themes
- **Conky** - System monitor displaying real-time information
- **Picom** - Compositor for transparency and visual effects

## Prerequisites

- Fresh Linux installation (Ubuntu 20.04+, Debian 11+, Arch, Fedora 35+)
- X11 (Xorg) display server
- Internet connection
- Sudo privileges

## Quick Start Installation

### 1. Install Base Packages

**Ubuntu/Debian:**
```bash
sudo apt update && sudo apt install -y \
    i3 i3status rofi conky picom kitty zsh \
    git curl wget feh nitrogen dunst \
    brightnessctl pavucontrol network-manager-applet \
    maim xclip fonts-font-awesome
```

**Arch Linux:**
```bash
sudo pacman -S i3-wm i3status rofi conky picom kitty zsh \
    git curl wget feh nitrogen dunst \
    brightnessctl pavucontrol network-manager-applet \
    maim xclip ttf-font-awesome
```

**Fedora:**
```bash
sudo dnf install -y i3 i3status rofi conky picom kitty zsh \
    git curl wget feh nitrogen dunst \
    brightnessctl pavucontrol network-manager-applet \
    maim xclip fontawesome-fonts
```

### 2. Install Required Fonts

```bash
# Create fonts directory
mkdir -p ~/.local/share/fonts

# Download MesloLGS NF (required for Powerlevel10k icons)
cd ~/.local/share/fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Update font cache
fc-cache -fv
```

### 3. Set Up Zsh with Oh My Zsh

```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Set Zsh as default shell
chsh -s $(which zsh)
```

**Note:** Log out and log back in for shell change to take effect.

### 4. Install Rofi Themes

```bash
# Install adi1090x's Rofi collection
git clone --depth=1 https://github.com/adi1090x/rofi.git ~/rofi-themes
cd ~/rofi-themes
chmod +x setup.sh
./setup.sh
cd ~ && rm -rf ~/rofi-themes
```

### 5. Clone Dotfiles Repository

```bash
# Backup existing configs
mkdir -p ~/.config-backup-$(date +%Y%m%d)
for file in .bashrc .zshrc .vimrc .gitconfig; do
    [ -f ~/$file ] && cp ~/$file ~/.config-backup-$(date +%Y%m%d)/
done

# Clone dotfiles as bare repository
echo ".cfg" >> ~/.gitignore
git clone --bare https://github.com/JaydeeNub/jaydee-dotfiles.git $HOME/.cfg

# Set up config alias
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no

# Checkout dotfiles
config checkout

# If checkout fails due to existing files, back them up:
# mkdir -p .config-backup && \
# config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
# config checkout

# Reload shell
source ~/.zshrc
```

### 6. Initial Configuration

```bash
# Verify i3 config syntax
i3 -C -c ~/.config/i3/config

# Configure Powerlevel10k (interactive wizard)
p10k configure

# Restart i3 to apply changes
i3-msg restart
```

## Post-Installation

### Configure Kitty Font

Edit `~/.config/kitty/kitty.conf`:
```conf
font_family      MesloLGS NF
font_size        12.0
background_opacity 0.85
```

### Configure Rofi Theme

Edit launcher style in `~/.config/rofi/launchers/type-1/launcher.sh`:
```bash
theme='style-5'  # Change to style-1 through style-15
```

Change colors in `~/.config/rofi/launchers/type-1/shared/colors.rasi`:
```css
@import "~/.config/rofi/colors/dracula.rasi"  # or nord, gruvbox, catppuccin, etc.
```

### Update Network Interface in Conky

Find your network interface:
```bash
ip link show | grep "state UP"
```

Edit both conky configs to use your interface name (e.g., replace `enp12s0` with yours):
- `~/.config/conky/conky_right.conf`
- `~/.config/conky/conky_left.conf`

## Managing Dotfiles

```bash
# Check status
config status

# Add new files
config add ~/.config/nvim/init.vim

# Commit changes
config commit -m "Update configuration"

# Push to remote
config push

# Pull updates
config pull

# View tracked files
config ls-files
```

## Updating Components

```bash
# Update Oh My Zsh
omz update

# Update Powerlevel10k
git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull

# Update plugins
git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions pull
git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting pull

# Reconfigure Powerlevel10k
p10k configure
```

## Essential Keybindings

| Keybinding | Action |
|------------|--------|
| `$mod+Enter` | Open terminal |
| `$mod+d` | Application launcher |
| `$mod+q` | Kill focused window |
| `$mod+Shift+e` | Power menu |
| `$mod+Tab` | Window switcher |
| `$mod+1-9` | Switch workspace |
| `$mod+Shift+1-9` | Move window to workspace |
| `$mod+Shift+c` | Reload i3 config |
| `$mod+Shift+r` | Restart i3 |
| `$mod+h/j/k/l` | Focus left/down/up/right |
| `$mod+Shift+h/j/k/l` | Move window |

**Note:** `$mod` is the Windows/Super key by default.

## Troubleshooting

**Icons not displaying:**
```bash
# Verify MesloLGS NF font is installed
fc-list | grep "MesloLGS NF"

# Check Kitty font config
grep "font_family" ~/.config/kitty/kitty.conf

# Reconfigure Powerlevel10k
p10k configure
```

**Conky not showing network:**
```bash
# Find your network interface
ip link show | grep "state UP"

# Update interface name in both conky configs
nano ~/.config/conky/conky_right.conf
nano ~/.config/conky/conky_left.conf
```

**Rofi launcher not working:**
```bash
# Test manually
rofi -show drun

# Make script executable
chmod +x ~/.config/rofi/launchers/type-1/launcher.sh
```

**Picom not starting:**
```bash
# Start manually
picom -b

# Check if already running
pgrep picom
```

## File Locations

```
~/.config/i3/config              # i3wm configuration
~/.config/kitty/kitty.conf       # Kitty terminal config
~/.zshrc                         # Zsh configuration
~/.p10k.zsh                      # Powerlevel10k settings
~/.config/rofi/                  # Rofi configurations
~/.config/conky/                 # Conky configs
~/.config/picom/picom.conf       # Picom compositor config
~/.cfg/                          # Dotfiles bare repository
```

## Resources

- [i3wm Documentation](https://i3wm.org/docs/userguide.html)
- [Kitty Terminal](https://sw.kovidgoyal.net/kitty/)
- [Oh My Zsh Wiki](https://github.com/ohmyzsh/ohmyzsh/wiki)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [adi1090x Rofi Collection](https://github.com/adi1090x/rofi)
- [Dotfiles Management Guide](https://www.atlassian.com/git/tutorials/dotfiles)
- [Kitty + Zsh + P10k Setup Guide](https://dev.to/protium/kitty-zsh-powerlevel10k-aesthetics-1e81)

## Credits

- i3wm community for tiling window manager workflows
- Aditya Shakya (adi1090x) for the beautiful Rofi collection
- Roman Perepelitsa for Powerlevel10k theme
- Oh My Zsh community for plugins ecosystem
- Dotfiles community for bare repository method

---

**License:** MIT

**Author:** JaydeeNub