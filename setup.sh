#!/usr/bin/env bash

set -euo pipefail

get_os() {
	unameOut="$(uname -s)"
	case "${unameOut}" in
	    Linux*)     machine=Linux;;
	    Darwin*)    machine=Mac;;
	    CYGWIN*)    machine=Cygwin;;
	    MINGW*)     machine=MinGw;;
	    *)          machine="UNKNOWN:${unameOut}"
	esac
	echo ${machine}
}

copy_dotfiles() {
	# copies over dotfiles and shell configuration
	rsync -azh ./.dotfiles ~
	rsync -azh ./.zshrc ~/.zshrc
	rsync -azh ./.gitconfig ~/.gitconfig

	# setup blank private variables
	touch ~/.private-environment-variables

	echo
	echo "The location to save private ENV vars for scripts:" ~/.private-environment-variables
	echo
}

install_homebrew() {
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	brew update

	printf "\n\nInstalled and updated Homebrew.\n\n"
}

install_homebrew_programs() {

	printf "\n\nInstalling programs from brew...\n\n"

	brew install tig

	# install fzf and completions
	brew install fzf
	/usr/local/opt/fzf/install


	printf "\n\nInstalled required programs from Homebrew.\n\n"
}

setup_ohmyzsh() {
	# install ZSH
	brew install zsh zsh-completions

	git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	chsh -s /bin/zsh
}

setup_pyenv() {
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	
	exec $SHELL

	# install recent as default
	pyenv install 3.6.4
	pyenv global 3.6.4
}

setup_nvm() {
	CURRENT_DIR=$PWD

	cd ~
	git clone https://github.com/creationix/nvm.git .nvm
	cd .nvm

	# pull version 0.33.8 - can be updated
	git checkout v0.33.8

	source ./nvm.sh

	# set node version as latest LTS and install
	echo "lts/*" > ~/.nvmrc
	nvm install

	cd $CURRENT_DIR
}

setup_sublime() {
	OS=$(get_os)

	if [ "$OS" == 'Linux' ]; then
		# symlink from dotfiles
		rm -rf ~/.config/sublime-text-3/Packages/User/
		ln -sf ~/.dotfiles/sublime/User/ ~/.config/sublime-text-3/Packages
	elif [ "$OS" == 'Darwin' ]; then
		# make it possible to invoke as a command
		ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

		# symlink from dotfiles
		rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
		ln -sf ~/.dotfiles/sublime/User/ ~/Library/Application\ Support/Sublime\ Text\ 3/Packages
	fi
}

run_setup() {
	OS=get_os

	copy_dotfiles
	install_homebrew
	setup_ohmyzsh
	setup_pyenv
	setup_nvm
	install_homebrew_programs
	setup_sublime
}
