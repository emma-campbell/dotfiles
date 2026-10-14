#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../../../utils.sh"

declare -r MISE_BIN="$HOME/.local/bin/mise"

# Point mise at the repo config directly — `link.sh` runs after
# this, so ~/.config/mise doesn't exist yet on a fresh machine.
export MISE_GLOBAL_CONFIG_FILE="$(cd ../../../config/mise && pwd)/config.toml"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_mise() {

	# Official installer drops the binary in ~/.local/bin,
	# which is where `.zshrc` activates it from.

	execute \
		"curl -fsSL https://mise.run | sh" \
		"mise (install)"
}

update_mise() {

	execute \
		"$MISE_BIN self-update --yes" \
		"mise (upgrade)"
}

install_tools() {

	execute \
		"$MISE_BIN install --yes" \
		"mise (install tools from config.toml)"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

	print_in_purple "\n   mise\n\n"

	if [ ! -x "$MISE_BIN" ]; then
		install_mise
	else
		update_mise
	fi

	install_tools
}

main
