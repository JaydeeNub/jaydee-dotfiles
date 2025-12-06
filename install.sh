#!/usr/bin/env bash
################################################################################
# Dotfiles Installation Script
# Installs all dependencies and sets up the environment for these dotfiles
################################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BLUE}===================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}===================================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Check if running on Arch Linux
if [[ ! -f /etc/arch-release ]]; then
    print_error "This script is designed for Arch Linux!"
    print_warning "You may need to adapt it for your distribution."
    read -p "Do you want to continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   print_error "This script should NOT be run as root (don't use sudo)"
   exit 1
fi

################################################################################
# Install AUR helper if not present
################################################################################

install_aur_helper() {
    print_header "Checking for AUR Helper"

    if command -v yay &> /dev/null; then
        print_success "yay is already installed"
        AUR_HELPER="yay"
        return
    elif command -v paru &> /dev/null; then
        print_success "paru is already installed"
        AUR_HELPER="paru"
        return
    fi

    print_warning "No AUR helper found. Installing yay..."

    # Install dependencies for building yay
    sudo pacman -S --needed --noconfirm git base-devel

    # Clone and build yay
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay

    AUR_HELPER="yay"
    print_success "yay installed successfully"
}

################################################################################
# Install Packages
################################################################################

install_packages() {
    print_header "Installing System Packages"

    # Update system first
    print_info "Updating system packages..."
    sudo pacman -Syu --noconfirm

    # Core packages
    PACKAGES=(
        # Window Manager & Display
        i3-wm
        xorg-server
        xorg-xinit
        xorg-xrandr
        xorg-setxkbmap

        # Terminal & Shell
        kitty
        zsh

        # Status Bar & Compositor
        polybar
        picom

        # Application Launcher & Menus
        rofi

        # System Utilities
        dunst                    # Notification daemon
        feh                      # Image viewer & wallpaper setter
        flameshot                # Screenshot tool
        playerctl                # Media player control
        brightnessctl            # Brightness control
        numlockx                 # Numlock control

        # Screen Locking
        i3lock
        scrot                    # Screenshot for blur-lock
        imagemagick              # Image processing for blur-lock
        xss-lock                 # Screen lock on suspend

        # Audio
        pulseaudio
        pulseaudio-alsa
        pavucontrol              # Audio control GUI

        # System Monitoring
        btop                     # Better alternative to bpytop

        # Other utilities
        jq                       # JSON processor
        autotiling               # Automatic tiling for i3
        dex                      # Desktop file execution
        git
        rsync                    # For backup aliases

        # Fonts
        ttf-jetbrains-mono
        ttf-font-awesome
        ttf-firacode
    )

    print_info "Installing ${#PACKAGES[@]} packages..."
    for package in "${PACKAGES[@]}"; do
        if pacman -Qi "$package" &> /dev/null; then
            print_success "$package (already installed)"
        else
            sudo pacman -S --needed --noconfirm "$package" && print_success "$package" || print_warning "$package (failed to install)"
        fi
    done
}

install_aur_packages() {
    print_header "Installing AUR Packages"

    AUR_PACKAGES=(
        brave-bin                # Browser
        greenclip                # Clipboard manager
    )

    print_info "Installing ${#AUR_PACKAGES[@]} AUR packages..."
    for package in "${AUR_PACKAGES[@]}"; do
        if pacman -Qi "$package" &> /dev/null; then
            print_success "$package (already installed)"
        else
            $AUR_HELPER -S --needed --noconfirm "$package" && print_success "$package" || print_warning "$package (failed to install)"
        fi
    done
}

################################################################################
# Install Oh-My-Zsh and plugins
################################################################################

install_oh_my_zsh() {
    print_header "Installing Oh-My-Zsh and Plugins"

    # Install Oh-My-Zsh if not already installed
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_info "Installing Oh-My-Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh-My-Zsh installed"
    else
        print_success "Oh-My-Zsh already installed"
    fi

    # Install Powerlevel10k theme
    if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
        print_info "Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
        print_success "Powerlevel10k installed"
    else
        print_success "Powerlevel10k already installed"
    fi

    # Install zsh-syntax-highlighting
    if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
        print_info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        print_success "zsh-syntax-highlighting installed"
    else
        print_success "zsh-syntax-highlighting already installed"
    fi

    # Install zsh-autosuggestions
    if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
        print_info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        print_success "zsh-autosuggestions installed"
    else
        print_success "zsh-autosuggestions already installed"
    fi
}

################################################################################
# Setup Dotfiles
################################################################################

setup_dotfiles() {
    print_header "Setting Up Dotfiles"

    DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    print_info "Dotfiles directory: $DOTFILES_DIR"

    # Create necessary directories
    mkdir -p ~/.config
    mkdir -p ~/Pictures/Wallpapers
    mkdir -p ~/.screenlayout

    # Symlink configuration files
    print_info "Creating symlinks..."

    # i3 config
    if [[ -d ~/.config/i3 ]]; then
        print_warning "~/.config/i3 already exists, backing up to ~/.config/i3.backup"
        mv ~/.config/i3 ~/.config/i3.backup
    fi
    ln -sf "$DOTFILES_DIR/.config/i3" ~/.config/i3
    print_success "Linked i3 config"

    # Polybar config
    if [[ -d ~/.config/polybar ]]; then
        print_warning "~/.config/polybar already exists, backing up to ~/.config/polybar.backup"
        mv ~/.config/polybar ~/.config/polybar.backup
    fi
    ln -sf "$DOTFILES_DIR/.config/polybar" ~/.config/polybar
    print_success "Linked polybar config"

    # Picom config
    if [[ -d ~/.config/picom ]]; then
        print_warning "~/.config/picom already exists, backing up to ~/.config/picom.backup"
        mv ~/.config/picom ~/.config/picom.backup
    fi
    ln -sf "$DOTFILES_DIR/.config/picom" ~/.config/picom
    print_success "Linked picom config"

    # Kitty config
    if [[ -d ~/.config/kitty ]]; then
        print_warning "~/.config/kitty already exists, backing up to ~/.config/kitty.backup"
        mv ~/.config/kitty ~/.config/kitty.backup
    fi
    ln -sf "$DOTFILES_DIR/.config/kitty" ~/.config/kitty
    print_success "Linked kitty config"

    # Rofi config
    if [[ -d ~/.config/rofi ]]; then
        print_warning "~/.config/rofi already exists, backing up to ~/.config/rofi.backup"
        mv ~/.config/rofi ~/.config/rofi.backup
    fi
    ln -sf "$DOTFILES_DIR/.config/rofi" ~/.config/rofi
    print_success "Linked rofi config"

    # Dotfiles common (colors, etc.)
    if [[ -d ~/.config/dotfiles-common ]]; then
        print_warning "~/.config/dotfiles-common already exists, backing up to ~/.config/dotfiles-common.backup"
        mv ~/.config/dotfiles-common ~/.config/dotfiles-common.backup
    fi
    ln -sf "$DOTFILES_DIR/.config/dotfiles-common" ~/.config/dotfiles-common
    print_success "Linked dotfiles-common"

    # Zshrc
    if [[ -f ~/.zshrc ]]; then
        print_warning "~/.zshrc already exists, backing up to ~/.zshrc.backup"
        mv ~/.zshrc ~/.zshrc.backup
    fi
    ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
    print_success "Linked .zshrc"

    # Make scripts executable
    print_info "Making scripts executable..."
    chmod +x "$DOTFILES_DIR/.config/i3/scripts/"*
    chmod +x "$DOTFILES_DIR/.config/polybar/"*.sh
    chmod +x "$DOTFILES_DIR/.config/rofi/launchers/type-2/"*.sh
    chmod +x "$DOTFILES_DIR/.config/rofi/powermenu/type-2/"*.sh
    chmod +x "$DOTFILES_DIR/.config/rofi/applets/bin/"*.sh
    print_success "Scripts are now executable"
}

################################################################################
# Change default shell
################################################################################

setup_shell() {
    print_header "Setting Up Shell"

    if [[ "$SHELL" != "$(which zsh)" ]]; then
        print_info "Changing default shell to zsh..."
        chsh -s $(which zsh)
        print_success "Default shell changed to zsh (will take effect on next login)"
    else
        print_success "Default shell is already zsh"
    fi
}

################################################################################
# Post-installation instructions
################################################################################

post_install_instructions() {
    print_header "Installation Complete!"

    echo -e "${GREEN}All packages and configurations have been installed.${NC}\n"

    print_info "Manual steps required:"
    echo "  1. Add a wallpaper to ~/Pictures/Wallpapers/dark-wallpaper.jpg"
    echo "  2. Create a monitor layout script at ~/.screenlayout/monitor.sh"
    echo "     (You can use arandr to generate this)"
    echo "  3. If using Powerlevel10k for the first time, run: p10k configure"
    echo "  4. Log out and log back in (or reboot) for all changes to take effect"
    echo "  5. When you log in, select i3 as your window manager"
    echo "  6. Configure your display setup using arandr and save to ~/.screenlayout/monitor.sh"

    echo -e "\n${YELLOW}Optional:${NC}"
    echo "  - Install additional fonts from AUR for better icon support"
    echo "  - Customize colors in ~/.config/dotfiles-common/colors.sh"
    echo "  - Review and customize keybindings in ~/.config/i3/config"

    echo -e "\n${GREEN}To start using i3 now:${NC}"
    echo "  1. Run 'exec i3' to start i3 (if already in X session)"
    echo "  2. Or log out and select i3 from your display manager"
}

################################################################################
# Main Installation Flow
################################################################################

main() {
    print_header "Dotfiles Installation Script"

    echo "This script will install all dependencies for the i3 dotfiles."
    echo "It will:"
    echo "  - Install system packages via pacman"
    echo "  - Install AUR packages (brave, greenclip)"
    echo "  - Install Oh-My-Zsh with plugins"
    echo "  - Symlink dotfiles to ~/.config"
    echo "  - Change your default shell to zsh"
    echo ""

    read -p "Do you want to continue? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Installation cancelled"
        exit 0
    fi

    install_aur_helper
    install_packages
    install_aur_packages
    install_oh_my_zsh
    setup_dotfiles
    setup_shell
    post_install_instructions
}

# Run main function
main
