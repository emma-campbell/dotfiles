#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../../../utils.sh" &&
	. "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Lazy Tools\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf "\n"
brew_install "Lazygit" "lazygit"
brew_install "Lazydocker" "lazydocker"
