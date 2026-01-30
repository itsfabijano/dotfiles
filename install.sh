#!/usr/bin/env bash

case "$(uname -s)" in
    Darwin) 
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
            echo "Oh My Zsh is not installed. Installing..."
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        else
            echo "Oh My Zsh is already installed."
        fi
        brew bundle install --file ./Brewfile
        brew bundle cleanup --file ./Brewfile
        ;;
    Linux)
        ;;
esac

stow -R -v -t ~ -d ~/repos/personal/dotfiles/home .

case "$(uname -s)" in
	Darwin) 
		echo "macOS"
		stow -R -v -t ~ -d ~/repos/personal/dotfiles/home.darwin .
	;;
	Linux)
    		echo "Linux"
    	;;
esac
