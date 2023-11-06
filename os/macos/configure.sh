#!/bin/bash
#
#

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../../utils.sh"

main() {

	print_in_purple ""\n • Configuring MacOS Environment \n\n""

	./homebrew.sh

	for f in install/*.sh; do
		"./$f"
	done
}

main
