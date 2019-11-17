#!/bin/bash

# Declares TEMP_DIR
TEMP_DIR=/tmp
# .xinitrc file
XINITRC_FILE=$HOME/.xinitrc
# function to clone git repositories
git_clone() {
	git clone $1
}

# function to clone from github
github_clone() {
	git_clone https://github.com/$1.git
}
# Install git so I can clone repositories and build prgrams
sudo pacman -S git --noconfirm

# Install rsync - used to copy files from repositories
sudo pacman -S extra/rsync --noconfirm
# Install vim editor
sudo pacman -S vim --noconfirm

# X Server
sudo pacman -S xorg --noconfirm
sudo pacman -S xorg-xinit --noconfirm

# Terminal emulator
sudo pacman -S termite --noconfirm

# Dependencies for bspwm
sudo pacman -S libxcb xcb-util xcb-util-keysyms xcb-util-wm --noconfirm
sudo pacman -S gcc make --noconfirm

# Window operations
sudo pacman -S xdotool --noconfirm

# wallpaper
sudo pacman -S feh --noconfirm

# Install pip3
sudo pacman -S extra/python-pip --noconfirm

# Generate colorscheme based on a image
sudo pip3 install pywal 

# Install imagemagick 
sudo pacman -S imagemagick --noconfirm

## Currently I'm using Qt
# Installing gtk dev
#pacman -S gtk3 --noconfirm
#
#pacman -S pkgconf --noconfirm

# Installing qt dev
sudo pacman -S qt5-base --noconfirm

# Installing docker
sudo pacman -S docker --noconfirm

## Docker post installation
### Docker auto start with os
sudo systemctl enable docker

### Start docker daemon
sudo systemctl start docker

### Docker group
sudo groupadd docker

sudo usermod -aG docker $USER

# Installing OpenJDK 8 and OpenJDK 11
sudo pacman -S jdk8-openjdk jre8-openjdk --noconfirm

sudo pacman -S jdk11-openjdk jre11-openjdk --noconfirm

# Cloning all repositories
cd /tmp

# Clone my dotfiles
github_clone vkhashimoto/dotfiles

# Clone bspwm (WM) and sxhkd (hotkey daemon)
github_clone baskerville/bspwm
github_clone baskerville/sxhkd

# Install bspwm
cd bspwm
make && sudo make install 
mkdir -p $HOME/.config/bspwm
# TODO Get from repository
# Copy example file from bspwm repository
cp examples/bspwmrc $HOME/.config/bspwm

# Keyboard shortcuts
mkdir -p $HOME/.config/sxhkd
# TODO Get from repository
cp examples/sxhkdrc $HOME/.config/sxhkd
cd $TEMP_DIR

# Install sxhkd
cd sxhkd
make && sudo make install
cd $TEMP_DIR

# Setup .xinitrc file
# Check if file exists and makes a copy
if [ -f "$XINITRC_FILE" ]; then
	cp "$XINITRC_FILE" $HOME/.xinitrc-bkp
	rm "$XINITRC_FILE"
	touch "$XINITRC_FILE"
fi

# Write to the file commands to start bspwm
echo -e "sxhkd &\nexec bspwm" > "$XINITRC_FILE"
# Copy my dotfiles to the $HOME directory
#cp -a dotfiles/. $HOME
cd dotfiles && git pull
chmod +x .config/bspwm/bspwmrc
cd $TEMP_DIR
rsync -av --exclude='.git' --exclude='README.md' dotfiles/. $HOME/



echo "Maybe you should logout and login to ensure that all changes are applied to your user"
