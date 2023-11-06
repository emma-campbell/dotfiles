#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../utils.sh"

run() {
	for FILE in $(find "$1" -type f -print | sort); do
		./$FILE
	done
}

main() {
	local os="$(get_os)"
	"./$os/configure.sh"
}

main
