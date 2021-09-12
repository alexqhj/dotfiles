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

install_packages
setup_local_gitconfig
#install_powerline_fonts
