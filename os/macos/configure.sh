#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../../utils.sh"

main() {

	./homebrew.sh

	for f in install/*.sh; do
		"./$f"
	done

	# Close any open `System Preferences` panes in order to
	# avoid overriding the preferences that are being changed.

	./prefs/close_system_prefs.applescript

	for f in prefs/*.sh; do
		"./$f"
	done

	./link.sh
}

main
