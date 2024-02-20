#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../../../utils.sh" &&
	. "../utils.sh"

install_oh_my_posh() {
	brew_tap jandedobbeleer/oh-my-posh && brew_install "Oh My Posh" "oh-my-posh"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Installing shell dependencies\n\n"

brew_install "ZSH Syntax Highlighting" "zsh-syntax-highlighting"
brew_install "ZSH Autosuggestions" "zsh-autosuggestions"
brew_install "ZSH Completions" "zsh-completions"
brew_install "Neovim" "neovim"
brew_install "Zoxide" "zoxide"

install_oh_my_posh
