# Complete Linux Dotfiles Setup Guide

A comprehensive guide for setting up a customized Linux desktop environment from scratch using i3wm, Kitty terminal, Zsh with Powerlevel10k, Rofi launcher, and more.

## Overview

This dotfiles repository provides a complete desktop configuration featuring a minimal, keyboard-driven Linux environment. The setup includes a tiling window manager, GPU-accelerated terminal, modern shell with beautiful prompt, application launcher, system monitor, and compositor for visual effects.

**What's included:**
- **i3wm** - Tiling window manager for efficient workspace management
- **Kitty** - GPU-accelerated terminal emulator with modern features
- **Zsh + Oh My Zsh** - Advanced shell with extensive plugin ecosystem
- **Powerlevel10k** - Fast, beautiful, and highly customizable prompt theme
- **Rofi** - Application launcher and dmenu replacement with custom themes
- **Conky** - Lightweight system monitor displaying system information
- **Picom** - Compositor providing transparency, shadows, and smooth visuals
- **Additional utilities** - Various scripts and configurations for a complete setup

## Final Setup Appearance

This configuration creates a beautiful, functional desktop environment with:
- Clean tiling window layout with customizable gaps between windows
- Transparent terminal windows with blur effects
- Beautiful, informative shell prompt showing Git status, directory, and system info
- Elegant application launcher with custom themes
- Real-time system monitoring overlay
- Smooth window animations and visual effects
- Fully keyboard-driven workflow for maximum productivity

## Prerequisites

Before starting, ensure you have a fresh Linux installation with:
- **Operating System**: Ubuntu 20.04+, Debian 11+, Arch Linux, Fedora 35+, or similar
- **Display Server**: X11 (Xorg) - required for i3wm
- **Internet Connection**: For downloading packages and fonts
- **Basic Tools**: `curl`, `wget`, `git` installed
- **User Privileges**: Sudo access for installing packages
- **Backup**: Create backups of any existing configuration files



**Install Zsh**

```bash
# Verify Zsh installation
zsh --version

# If not installed, install it (should already be installed from Phase 1)
# Ubuntu/Debian: sudo apt install zsh
# Arch: sudo pacman -S zsh
# Fedora: sudo dnf install zsh
```

**Set Zsh as Default Shell**

```bash
# Set Zsh as default shell
chsh -s $(which zsh)

# On Fedora, use:
# sudo chsh $USER -s $(which zsh)

# Verify the change
echo $SHELL
```

**Important:** Log out and log back in for the shell change to take effect.

**Install Oh My Zsh**

```bash
# Install Oh My Zsh via curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Or via wget if curl is unavailable
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**Install Powerlevel10k Theme**

```bash
# Clone Powerlevel10k into Oh My Zsh custom themes directory
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

**Install Essential Zsh Plugins**

```bash
# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Install Rofi Themes Collection

The adi1090x Rofi collection provides beautiful pre-made launchers and applets.

```bash
# Clone the adi1090x/rofi repository
git clone --depth=1 https://github.com/adi1090x/rofi.git ~/rofi-themes

# Navigate to directory
cd ~/rofi-themes

# Make setup script executable
chmod +x setup.sh

# Run installation
./setup.sh

# Clean up
cd ~
rm -rf ~/rofi-themes
```

This installs:
- 7 launcher types with 15+ styles each
- 6 powermenu types
- Multiple applets (battery, brightness, network, volume, etc.)
- 15+ color schemes (Dracula, Nord, Gruvbox, Catppuccin, etc.)

### Phase 5: Clone and Set Up Dotfiles Repository

**Using the Bare Repository Method**

This elegant approach uses Git to manage dotfiles without symlinks.

**Step 1: Create Backup of Existing Configs**

```bash
# Create backup directory with timestamp
mkdir -p ~/.config-backup-$(date +%Y%m%d)

# Backup common config files if they exist
for file in .bashrc .zshrc .vimrc .gitconfig; do
    [ -f ~/$file ] && cp ~/$file ~/.config-backup-$(date +%Y%m%d)/
done

# Backup config directories
[ -d ~/.config/i3 ] && cp -r ~/.config/i3 ~/.config-backup-$(date +%Y%m%d)/
[ -d ~/.config/kitty ] && cp -r ~/.config/kitty ~/.config-backup-$(date +%Y%m%d)/
```

**Step 2: Clone the Dotfiles Repository**

```bash
# Add .cfg to gitignore (prevents recursive tracking issues)
echo ".cfg" >> ~/.gitignore

# Clone your dotfiles repository as a bare repo
# Replace with your actual repository URL
git clone --bare https://github.com/JaydeeNub/jaydee-dotfiles.git $HOME/.cfg
```

**Step 3: Define the Config Alias**

```bash
# Create temporary alias for current session
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Configure to hide untracked files
config config --local status.showUntrackedFiles no
```

**Step 4: Checkout Your Dotfiles**

```bash
# Attempt to checkout
config checkout

# If you get errors about existing files, back them up automatically:
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

# Retry checkout
config checkout
```

**Step 5: Make the Alias Permanent**

The checkout should have included `.bashrc` or `.zshrc` with the alias, but verify:

```bash
# Check if alias exists in .zshrc
grep "alias config=" ~/.zshrc

# If not present, add it manually
echo "alias config='/usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'" >> ~/.zshrc

# Reload shell configuration
source ~/.zshrc
```

### Phase 6: Configure Individual Components

#### Configure i3wm

The dotfiles should include a complete i3 config, but here's the typical structure:

**Location:** `~/.config/i3/config`

**Key modifications to verify:**

1. **Set modifier key** (usually Windows key)
2. **Configure autostart applications**
3. **Set up keybindings** for launchers and common apps
4. **Configure workspaces** and window rules
5. **Set up status bar** (i3bar or i3blocks)

**Verify your config:**

```bash
# Check for syntax errors
i3 -C -c ~/.config/i3/config

# If no errors, reload i3
i3-msg reload
```

**First login to i3:**

```bash
# Log out of current session
# Select i3 from your display manager login screen
# On first launch, accept the config generation prompt
```

#### Configure Kitty Terminal

**Location:** `~/.config/kitty/kitty.conf`

**Essential settings to verify:**

```conf
# Font configuration
font_family      MesloLGS NF
font_size        12.0

# Terminal aesthetics
background_opacity 0.85
window_padding_width 4

# Tab bar
tab_bar_edge top
tab_bar_style powerline

# Reload config shortcut
map ctrl+shift+f5 load_config_file
```

**Test Kitty:**

```bash
# Launch Kitty (use from terminal or rofi)
kitty

# Inside Kitty, test font rendering with icons
echo ""  # Should show a git branch icon
```

#### Configure Zsh and Powerlevel10k

**Edit `~/.zshrc`:**

1. **Set theme:**
```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

2. **Enable plugins:**
```bash
plugins=(
    git
    ...
)
```

3. **Run Powerlevel10k configuration wizard:**
```bash
# Restart terminal, then run:
p10k configure

# This will guide you through customization options:
# - Prompt style (Rainbow, Lean, Classic, Pure)
# - Character set (Unicode recommended)
# - Time display
# - Separators and prompt appearance
# - Transient prompt (recommended: yes)
# - Instant prompt mode (recommended: verbose)
```

#### Configure Rofi

**Location:** `~/.config/rofi/config.rasi`

The adi1090x installation provides multiple launcher styles. Customize by editing:

```bash
# Edit launcher script to change style
nano ~/.config/rofi/launchers/type-1/launcher.sh

# Change the theme variable:
theme='style-1'  # Try style-1 through style-15

# Change color scheme by editing:
nano ~/.config/rofi/launchers/type-1/shared/colors.rasi

# Import different color:
@import "~/.config/rofi/colors/nord.rasi"
# Available: adapta, arc, catppuccin, dracula, everforest, gruvbox, nord, onedark, solarized, etc.
```


## Managing Your Dotfiles

### Repo Usage Commands

```bash
# Check status of tracked files
config status

# Add new configuration files
config add .config/neovim/init.vim

# Commit changes
config commit -m "Update neovim configuration"

# Push to remote repository
config push

# Pull updates from remote
config pull

# View all tracked files
config ls-files
```

### Updating Your Setup


**Update Oh My Zsh:**

```bash
omz update
```

**Update Powerlevel10k:**

```bash
git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull
```

**Update Zsh plugins:**

```bash
# zsh-autosuggestions
git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions pull

# zsh-syntax-highlighting
git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting pull
```

**Reconfigure Powerlevel10k:**

```bash
p10k configure
```




## Resources and Credits

### Official Documentation

- **i3wm User Guide**: https://i3wm.org/docs/userguide.html - Complete i3 window manager documentation
- **Kitty Terminal**: https://sw.kovidgoyal.net/kitty/ - GPU-accelerated terminal emulator
- **Oh My Zsh Wiki**: https://github.com/ohmyzsh/ohmyzsh/wiki - Framework for managing Zsh configuration
- **Powerlevel10k**: https://github.com/romkatv/powerlevel10k - Fast and flexible Zsh theme
- **Rofi**: https://github.com/davatorium/rofi - Window switcher and application launcher
- **adi1090x Rofi Collection**: https://github.com/adi1090x/rofi - Beautiful Rofi themes and applets
- **Picom Compositor**: https://github.com/yshui/picom - Standalone compositor for X11
- **Conky**: https://github.com/brndnmtthws/conky - Lightweight system monitor

### Tutorials and Guides

- **Kitty + Zsh + Powerlevel10k Aesthetics**: https://dev.to/protium/kitty-zsh-powerlevel10k-aesthetics-1e81 - Complete terminal setup guide
- **Dotfiles Management with Bare Git Repository**: https://www.atlassian.com/git/tutorials/dotfiles - Elegant dotfiles management approach

### Community Resources

- **r/unixporn** - Reddit community showcasing beautiful Unix/Linux customizations
- **r/i3wm** - i3 window manager community and support
- **ArchWiki** - Comprehensive documentation (useful for all distributions):
  - https://wiki.archlinux.org/title/I3
  - https://wiki.archlinux.org/title/Rofi
  - https://wiki.archlinux.org/title/Picom

### Credits

This setup guide integrates best practices and inspiration from:
- The i3wm community for tiling window manager workflows
- Aditya Shakya (adi1090x) for the beautiful Rofi theme collection
- Roman Perepelitsa for the excellent Powerlevel10k theme
- The Oh My Zsh community for the extensive plugin ecosystem
- The dotfiles community for the bare repository management technique

## Quick Reference

### Essential Commands

**i3wm:**
- `$mod+Enter` - Open terminal
- `$mod+d` - Application launcher
- `$mod+q` - Kill focused window
- `$mod+[1-9]` - Switch workspace
- `$mod+Shift+c` - Reload config
- `$mod+Shift+r` - Restart i3
- `$mod+Tab` - Window switcher
- `$mod+Shift+e` - Power menu

**Dotfiles:**
- `config status` - Check dotfiles status
- `config add <file>` - Track new file
- `config commit -m "message"` - Commit changes
- `config push` - Push to remote
- `config pull` - Pull updates

**Shell:**
- `p10k configure` - Reconfigure prompt
- `omz update` - Update Oh My Zsh

### File Locations Reference

```
~/.config/i3/config              # i3wm configuration
~/.config/kitty/kitty.conf       # Kitty terminal config
~/.zshrc                         # Zsh configuration
~/.p10k.zsh                      # Powerlevel10k settings
~/.config/rofi/                  # Rofi configurations and themes
~/.config/conky/conky.conf       # Conky system monitor config
~/.config/picom/picom.conf       # Picom compositor config
```

---

**Note**: This documentation is designed for a fresh Linux installation. Always backup your existing configurations before applying these dotfiles. For system-specific adjustments, consult the troubleshooting section or refer to the official documentation links provided.