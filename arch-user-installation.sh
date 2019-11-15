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
sudo pacman -S git -y

# Install vim editor
sudo pacman -S vim -y

# X Server
sudo pacman -S xorg -y
sudo pacman -S xorg-xinit -y

# Terminal emulator
sudo pacman -S termite

# Dependencies for bspwm
sudo pacman -S libxcb xcb-util xcb-util-keysyms xcb-util-wm -y
sudo pacman -S gcc make -y

# Cloning all repositories
cd /tmp

# Clone my dotfiles
github_clone vkhashimoto/dotfiles

# Clone bspwm (WM) and sxhkd (hotkey daemon)
github_clone baskerville/bspwm
github_clone baskerville/sxhkd

# Install bspwm
cd bspwm && make && sudo make install && cd $TEMP_DIR

# Install sxhkd
cd sxhkd && make && sudo make install && cd $TEMP_DIR

# Setup .xinitrc file
if [ -f "$XINITRC_FILE" ]; then
	cp "$XINITRC_FILE" $HOME/.xinitrc-bkp
	rm "$XINITRC_FILE"
	touch "$XINITRC_FILE"
	echo -e "sxhkd &\nexec bspwm" > "$XINITRC_FILE"
fi

# Copy my dotfiles to the $HOME directory
cp -a dotfiles/. $HOME
