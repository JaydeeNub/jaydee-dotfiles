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

## Step-by-Step Installation

### Phase 1: Install Core System Packages

#### On Ubuntu/Debian

```bash
# Update package lists
sudo apt update

# Install core window manager and utilities
sudo apt install -y i3 i3status i3lock dmenu \
    xorg xserver-xorg xinit \
    build-essential git curl wget

# Install additional tools
sudo apt install -y rofi conky picom \
    kitty zsh \
    feh nitrogen lxappearance \
    dunst libnotify-bin \
    brightnessctl \
    pavucontrol pulseaudio \
    network-manager-applet \
    scrot maim xclip
```

#### On Arch Linux

```bash
# Update system
sudo pacman -Syu

# Install core packages
sudo pacman -S i3-wm i3status i3lock rofi \
    xorg xorg-xinit \
    base-devel git curl wget

# Install additional tools
sudo pacman -S conky picom kitty zsh \
    feh nitrogen lxappearance \
    dunst libnotify \
    brightnessctl \
    pavucontrol pulseaudio \
    network-manager-applet \
    maim xclip scrot
```

#### On Fedora

```bash
# Update system
sudo dnf update -y

# Install core packages
sudo dnf install -y i3 i3-ipc i3status i3lock rofi \
    xorg-x11-server-Xorg xorg-x11-xinit \
    @development-tools git curl wget

# Install additional tools
sudo dnf install -y conky picom kitty zsh \
    feh nitrogen lxappearance \
    dunst libnotify \
    brightnessctl \
    pavucontrol pulseaudio \
    network-manager-applet \
    scrot maim xclip
```

### Phase 2: Install and Configure Fonts

**Essential: Install Nerd Fonts for proper icon display**

Powerlevel10k requires MesloLGS NF (Meslo Nerd Font) for all icons and symbols to display correctly.

```bash
# Create fonts directory
mkdir -p ~/.local/share/fonts

# Download MesloLGS NF fonts
cd ~/.local/share/fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Update font cache
fc-cache -fv

# Verify installation
fc-list | grep "MesloLGS NF"
```

### Phase 3: Install Zsh and Oh My Zsh

**Step 1: Install Zsh**

```bash
# Verify Zsh installation
zsh --version

# If not installed, install it (should already be installed from Phase 1)
# Ubuntu/Debian: sudo apt install zsh
# Arch: sudo pacman -S zsh
# Fedora: sudo dnf install zsh
```

**Step 2: Set Zsh as Default Shell**

```bash
# Set Zsh as default shell
chsh -s $(which zsh)

# On Fedora, use:
# sudo chsh $USER -s $(which zsh)

# Verify the change
echo $SHELL
```

**Important:** Log out and log back in for the shell change to take effect.

**Step 3: Install Oh My Zsh**

```bash
# Install Oh My Zsh via curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Or via wget if curl is unavailable
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**Step 4: Install Powerlevel10k Theme**

```bash
# Clone Powerlevel10k into Oh My Zsh custom themes directory
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

**Step 5: Install Essential Zsh Plugins**

```bash
# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Phase 4: Install Rofi Themes Collection

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
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
    kubectl
    sudo
    extract
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

#### Configure Conky

**Location:** `~/.config/conky/conky.conf`

Basic Conky configuration (Lua format):

```lua
conky.config = {
    background = false,
    update_interval = 1.0,
    
    -- Window settings for i3wm
    own_window = true,
    own_window_type = 'desktop',
    own_window_transparent = true,
    own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
    
    -- Position
    alignment = 'top_right',
    gap_x = 20,
    gap_y = 50,
    minimum_width = 250,
    
    -- Font
    use_xft = true,
    font = 'DejaVu Sans Mono:size=10',
    
    -- Colors
    default_color = 'white',
    color1 = 'gray',
}

conky.text = [[
${color1}System Info${color}
${hr}
Uptime: $uptime
CPU: ${cpu}% ${cpubar 6}
RAM: $mem/$memmax
${membar 6}
Disk: ${fs_used /}/${fs_size /}
${fs_bar 6 /}

${color1}Network${color}
${hr}
Down: ${downspeed eth0}
Up: ${upspeed eth0}
]]
```

#### Configure Picom Compositor

**Location:** `~/.config/picom/picom.conf`

```bash
# Create picom config directory
mkdir -p ~/.config/picom

# Copy default config as starting point
cp /etc/xdg/picom.conf ~/.config/picom/picom.conf

# Edit for i3wm optimization
nano ~/.config/picom/picom.conf
```

**Essential settings for i3wm:**

```conf
# Backend (GLX for best performance)
backend = "glx";
vsync = true;

# Shadows
shadow = true;
shadow-radius = 12;
shadow-offset-x = -7;
shadow-offset-y = -7;
shadow-opacity = 0.7;

# Exclude i3 window borders and bars from shadows
shadow-exclude = [
    "class_g = 'i3-frame'",
    "class_g = 'i3bar'"
];

# Fading
fading = true;
fade-delta = 5;
fade-in-step = 0.03;
fade-out-step = 0.03;

# Transparency
inactive-opacity = 0.85;
active-opacity = 1.0;
frame-opacity = 0.9;

# Blur (optional, may impact performance)
blur-background = true;
blur-method = "dual_kawase";
blur-strength = 5;

# Performance
glx-no-stencil = true;
glx-no-rebind-pixmap = true;
```

### Phase 7: Set Up Autostart

**Edit i3 config** (`~/.config/i3/config`) to ensure applications start automatically:

```bash
# Add these lines to your i3 config

# Compositor
exec_always --no-startup-id picom -b

# System monitor
exec_always --no-startup-id conky

# Notification daemon
exec --no-startup-id dunst

# Network manager applet
exec --no-startup-id nm-applet

# Wallpaper (if using feh)
exec_always --no-startup-id feh --bg-scale ~/.config/wallpapers/main.jpg

# Or wallpaper (if using nitrogen)
exec_always --no-startup-id nitrogen --restore

# Audio control
exec --no-startup-id pulseaudio --start
```

### Phase 8: Configure Keybindings

**Essential i3 keybindings** to add or verify in `~/.config/i3/config`:

```bash
# Set modifier key (Windows key)
set $mod Mod4

# Terminal
bindsym $mod+Return exec --no-startup-id kitty

# Rofi application launcher
bindsym $mod+d exec --no-startup-id ~/.config/rofi/launchers/type-1/launcher.sh

# Rofi window switcher
bindsym $mod+Tab exec --no-startup-id rofi -show window

# Rofi powermenu
bindsym $mod+Escape exec --no-startup-id ~/.config/rofi/powermenu/type-1/powermenu.sh

# Rofi applets
bindsym $mod+n exec --no-startup-id ~/.config/rofi/applets/bin/network.sh
bindsym $mod+v exec --no-startup-id ~/.config/rofi/applets/bin/volume.sh

# Screenshots
bindsym Print exec --no-startup-id maim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png
bindsym $mod+Print exec --no-startup-id maim -s ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png

# Volume control (if using pactl)
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle

# Brightness control
bindsym XF86MonBrightnessUp exec --no-startup-id brightnessctl set +5%
bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl set 5%-

# Lock screen
bindsym $mod+Shift+x exec --no-startup-id i3lock -c 000000

# Reload i3 config
bindsym $mod+Shift+c reload

# Restart i3
bindsym $mod+Shift+r restart

# Restart picom
bindsym $mod+Shift+p exec --no-startup-id "killall picom; picom -b"
```

### Phase 9: Final Setup and Testing

**Step 1: Reload all configurations**

```bash
# Reload Zsh configuration
source ~/.zshrc

# Reload i3 configuration
i3-msg reload

# Or restart i3 completely
i3-msg restart
```

**Step 2: Test each component**

1. **Terminal and Shell:**
   - Press `$mod+Return` to open Kitty
   - Verify MesloLGS NF font displays correctly
   - Check Powerlevel10k theme appears with icons
   - Test autosuggestions by typing partial commands

2. **Application Launcher:**
   - Press `$mod+d` to open Rofi launcher
   - Type application names to search
   - Verify theme and colors display correctly

3. **Window Management:**
   - Open multiple windows
   - Test tiling (horizontal/vertical splits)
   - Switch between workspaces with `$mod+[1-9]`
   - Move windows between workspaces with `$mod+Shift+[1-9]`

4. **Visual Effects:**
   - Verify transparency on unfocused windows
   - Check shadows appear around windows
   - Test fading effects when opening/closing windows

5. **System Monitor:**
   - Verify Conky appears in the correct position
   - Check system information updates in real-time

**Step 3: Log out and log in through display manager**

```bash
# Log out
i3-msg exit

# Select i3 from your display manager
# Log in with your credentials
```

All components should now start automatically on login.

## Managing Your Dotfiles

### Daily Usage Commands

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

**Update system packages:**

```bash
# Ubuntu/Debian
sudo apt update && sudo apt upgrade

# Arch
sudo pacman -Syu

# Fedora
sudo dnf update
```

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

## Troubleshooting

### i3wm Issues

**Black screen on login:**
- Check logs: `journalctl -xe | grep i3`
- Verify X server: `echo $DISPLAY`
- Check i3 config syntax: `i3 -C -c ~/.config/i3/config`

**Keybindings not working:**
- Reload config: `$mod+Shift+c`
- Verify modifier key: `xmodmap | grep mod`
- Check for conflicts in config

**Windows not tiling correctly:**
- Verify i3 is running: `pgrep i3`
- Check window rules in config
- Reset layout: `$mod+e`

### Terminal and Shell Issues

**Icons not displaying in Powerlevel10k:**
- Verify MesloLGS NF font is installed: `fc-list | grep MesloLGS`
- Check Kitty font config: `cat ~/.config/kitty/kitty.conf | grep font_family`
- Run font configuration: `p10k configure`

**Zsh plugins not working:**
- Check plugins are installed: `ls ~/.oh-my-zsh/custom/plugins/`
- Verify plugins enabled in `.zshrc`: `grep "plugins=" ~/.zshrc`
- Reload Zsh: `source ~/.zshrc`

**Slow Zsh startup:**
- Enable instant prompt in Powerlevel10k
- Disable unused plugins
- Profile startup: Add `zmodload zsh/zprof` to top of `.zshrc` and `zprof` to bottom

### Rofi Issues

**Rofi launcher not appearing:**
- Test manually: `rofi -show drun`
- Check script permissions: `ls -l ~/.config/rofi/launchers/type-1/launcher.sh`
- Make executable: `chmod +x ~/.config/rofi/launchers/type-1/launcher.sh`

**Themes not applying:**
- Verify theme files exist: `ls ~/.config/rofi/themes/`
- Check color imports in config
- Run theme selector: `rofi-theme-selector`

### Visual Effects Issues

**Picom not starting:**
- Check if running: `pgrep picom`
- Start manually: `picom -b`
- Check logs: `picom --log-level=debug --log-file=/tmp/picom.log`

**No transparency or shadows:**
- Verify backend: Check `backend = "glx"` in picom.conf
- Test OpenGL support: `glxinfo | grep "direct rendering"`
- Try alternate backend: `backend = "xrender"`

**Screen tearing:**
- Enable VSync in picom.conf: `vsync = true`
- Try different backend
- Check graphics drivers

### Conky Issues

**Conky not visible:**
- Check if running: `pgrep conky`
- Verify window settings in config
- For i3wm, ensure: `own_window_type = 'desktop'`

**Conky displays on wrong monitor:**
- Set alignment and gap values in config
- Use `xrandr` to identify monitor layout
- Adjust `gap_x` and `gap_y` values

### Font Issues

**Missing or broken icons:**
```bash
# Reinstall fonts
cd ~/.local/share/fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fc-cache -fv
```

### Dotfiles Management Issues

**"Not a git repository" error:**
```bash
# Verify .cfg exists
ls -la ~/.cfg

# Re-create alias
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

**Too many untracked files showing:**
```bash
config config --local status.showUntrackedFiles no
```

**Conflicts when checking out:**
```bash
# Backup conflicting files
mkdir -p ~/.config-backup
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} ~/.config-backup/{}
config checkout
```

## Customization Guide

### Changing Color Schemes

**i3wm colors:**

Edit `~/.config/i3/config`:

```bash
# Define color variables
set $bg-color            #2f343f
set $inactive-bg-color   #2f343f
set $text-color          #f3f4f5
set $inactive-text-color #676e7d
set $urgent-bg-color     #e53935

# Apply to windows
# class                 border              background         text                 indicator
client.focused          $bg-color           $bg-color          $text-color          #00ff00
client.unfocused        $inactive-bg-color  $inactive-bg-color $inactive-text-color #00ff00
client.focused_inactive $inactive-bg-color  $inactive-bg-color $inactive-text-color #00ff00
client.urgent           $urgent-bg-color    $urgent-bg-color   $text-color          #00ff00
```

**Kitty colors:**

Edit `~/.config/kitty/kitty.conf`:

```conf
# Example: Gruvbox Dark color scheme
background  #282828
foreground  #ebdbb2
cursor      #ebdbb2

# Black
color0  #282828
color8  #928374

# Red
color1  #cc241d
color9  #fb4934

# Green
color2  #98971a
color10 #b8bb26

# Yellow
color3  #d79921
color11 #fabd2f

# Blue
color4  #458588
color12 #83a598

# Magenta
color5  #b16286
color13 #d3869b

# Cyan
color6  #689d6a
color14 #8ec07c

# White
color7  #a89984
color15 #ebdbb2
```

**Rofi colors:**

Edit `~/.config/rofi/launchers/type-1/shared/colors.rasi`:

```css
/* Change color scheme import */
@import "~/.config/rofi/colors/gruvbox.rasi"
/* Available: dracula, nord, catppuccin, onedark, solarized, etc. */
```

### Adding Custom Scripts

Create a scripts directory:

```bash
mkdir -p ~/.local/bin

# Add to PATH in .zshrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
```

**Example: Custom lock screen script**

Create `~/.local/bin/lock.sh`:

```bash
#!/bin/bash
# Take screenshot, blur it, and use as lock screen background
maim /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x8 /tmp/screenshot-blur.png
i3lock -i /tmp/screenshot-blur.png
```

Make executable and use:

```bash
chmod +x ~/.local/bin/lock.sh

# Add to i3 config
bindsym $mod+Shift+x exec --no-startup-id ~/.local/bin/lock.sh
```

### Workspace Customization

Define named workspaces in i3 config:

```bash
# Define workspace names
set $ws1 "1:  Terminal"
set $ws2 "2:  Web"
set $ws3 "3:  Code"
set $ws4 "4:  Files"
set $ws5 "5:  Media"
set $ws6 "6"
set $ws7 "7"
set $ws8 "8"
set $ws9 "9"
set $ws10 "10:  Music"

# Assign applications to workspaces
assign [class="Firefox"] $ws2
assign [class="Code"] $ws3
assign [class="Spotify"] $ws10

# Switch to workspace
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
# ... etc
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
- `$mod+Shift+q` - Kill window
- `$mod+[1-9]` - Switch workspace
- `$mod+Shift+c` - Reload config
- `$mod+Shift+r` - Restart i3

**Rofi:**
- `$mod+d` - Application launcher
- `$mod+Tab` - Window switcher
- `$mod+Escape` - Power menu

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
~/.cfg/                          # Dotfiles bare git repository
```

---

**Note**: This documentation is designed for a fresh Linux installation. Always backup your existing configurations before applying these dotfiles. For system-specific adjustments, consult the troubleshooting section or refer to the official documentation links provided.