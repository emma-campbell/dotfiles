#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../../../utils.sh" &&
	. "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Git Tools\n\n"

brew_install "GitHub CLI" "gh"
