#!/usr/bin/env bash

BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m'

DOTFILES_DIR="/tmp/dotfiles"

install () {
    if yay -Q $1 >/dev/null 2>&1; then
        echo -e "${BLUE}$1 is installed${NC}"
    else
        echo -e "${YELLOW}Installing $1${NC}"
        # yay -S --noconfirm --needed $1
    fi
}

# ESSENTIALS
## WM
install 'picom'
install 'i3-wm'
install 'i3lock'
install 'i3status'

## Terminal emulator
install 'alacritty'

## LSPs
install 'lua-language-server'
install 'jdtls'
install 'typescript-language-server'

## System
install 'pipewire'
install 'pavucontrol'
install 'feh'
install 'flameshot'
install 'imagemagick'
install 'arandr'
install 'neovim'
install 'xclip'
install 'scrot'
install 'xidlehook'
install 'dmenu'

WITHPERSONAL=false
DOTFILES=false

while getopts "wpd" opt; do
    case ${opt} in
        w) 
            WITHPERSONAL=true
            ;;
        p) 
            ;;
        d) 
            DOTFILES=true
            ;;
        *)
            echo "Usage: $0 [-w] [-d] for withpersonal and dotfiles setup"
            exit 1
            ;;
    esac
done

if $WITHPERSONAL; then
    echo -e "${GREEN}Setting up personal tools${NC}"
    install 'thunar'
    install 'vlc'
    install 'virtualbox'
    install 'virtualbox-host-modules-arch'
    install 'qdigidoc4'
    install 'obs-studio'
    install 'vlc'
    install 'thunar'
    install 'google-chrome'
    install 'docker'
    install 'docker-compose'
    install 'nodejs'
    install 'intellij-idea-ultimate-edition'
    install 'jdk17-openjdk'
    install 'lua'
    install 'spotify'
else
    echo -e "${YELLOW}--withpersonal flag missing, skipping personal tools setup${NC}"
fi

if $DOTFILES; then
    echo -e "${GREEN}Setting up dotfiles${NC}"
else
    echo -e "${YELLOW}--dotfiles flag missing, skipping dotfiles setup${NC}"
fi


if ! grep -q "exec startx" "/etc/profile"; then
    echo -e "${YELLOW}Adding 'exec startx' to /etc/profile${NC}"
    
    # Append the new block to /etc/profile
    sudo sh -c 'cat <<EOF >> /etc/profile

if [[ "\$(tty)" == "/dev/tty1" ]]; then
    exec startx
fi
EOF'
fi

if ! grep -q "exec i3" "~/.xinitrc"; then
    echo "${YELLOW}adding 'exec i3' to ~/.xinitrc${NC}"
    sudo sh -c 'echo -e "exec i3" >> ~/.xinitrc'
fi

