#!/bin/bash

GITCONFIG_LOCAL=~/.config/git/config.local

ask() {
  printf "\e[0;33m$1 \e[0m";
  read
}

install_packages() {
    sudo apt-get update && sudo apt-get install \
	    terminator \
	    git \
	    htop
}

setup_local_gitconfig() {
    if [ ! -f $GITCONFIG_LOCAL ]; then
        echo "Creating a local $GITCONFIG_LOCAL"

        ask "What is your Git name?"
        git_name=$REPLY
        ask "What is your Git email?"
        git_email=$REPLY
        echo -e "[user]\n    name = $git_name\n    email = $git_email" > $GITCONFIG_LOCAL
    fi
}

install_powerline_fonts() {
	cd $HOME
	git clone https://github.com/powerline/fonts.git powerline-fonts
	./powerline-fonts/install.sh
	sudo rm -rf powerline-fonts
}

install_oh-my-zsh () {
    if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
        if [[ ! -d ~/.oh-my-zsh/ ]]; then
            echo "Cloning robbyrussell/oh-my-zsh"
            git clone --depth=1 http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
        else
            echo "Oh-My-Zsh is already installed."
        fi

        ask "Do you want to make Zsh your default shell?"
        if [[ "$REPLY" =~ ^[Yy]$  ]]; then
            chsh -s $(which zsh)
        fi
    else
        echo -e "\nZsh is not installed. Installing ..."
        sudo apt-get install zsh
        install_oh-my-zsh
    fi
}

install_packages
setup_local_gitconfig
install_oh-my-zsh
install_powerline_fonts
