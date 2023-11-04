#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../../../utils.sh" &&
	. "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_zsh_syntax_highlighting() {
	brew_install "ZSH Syntax Highlighting" "zsh-syntax-highlighting"
	print_result $? "zsh-syntax-highlighting"
}

install_zsh_autosuggestions() {
	brew_install "ZSH Autosuggestions" "zsh-autosuggestions"
	print_result $? "zsh-autosuggestions"
}

install_zsh_completions() {
	brew_install "ZSH Completions" "zsh-completions"
	print_result $? "zsh-completions"
}

install_plugins() {
	install_zsh_syntax_highlighting &&
		install_zsh_autosuggestions &&
		install_zsh_completions
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_oh_my_posh() {
	brew_tap jandedobbeleer/oh-my-posh && brew_install "Oh My Posh" "oh-my-posh"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
	print_in_purple "\n   Installing shell dependencies\n\n"
	install_oh_my_posh && install_plugins
}

main
