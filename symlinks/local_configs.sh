#!/bin/bash
#
# Create _all_ local configs (~/.*.local)
#

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../utils.sh"

create_node_local() {
	declare -r FILE_PATH="$HOME/.node.local"

	if [ ! -e "$FILE_PATH" ]; then
		printf "" >>"$FILE_PATH"
	fi

	print_result $? "$FILE_PATH"
}

create_java_local() {
	declare -r FILE_PATH="$HOME/.java.local"

	if [ ! -e "$FILE_PATH" ]; then
		printf "" >>"$FILE_PATH"
	fi

	print_result $? "$FILE_PATH"
}

create_zsh_local() {
	declare -r FILE_PATH="$HOME/.zshrc.local"

	if [ ! -e "$FILE_PATH" ]; then
		printf "" >>"$FILE_PATH"
	fi

	print_result $? "$FILE_PATH"
}

create_aliases_local() {
	declare -r FILE_PATH="$HOME/.aliases.local"

	if [ ! -e "$FILE_PATH" ]; then
		printf "" >>"$FILE_PATH"
	fi

	print_result $? "$FILE_PATH"
}

create_gitconfig_local() {
	declare -r FILE_PATH="$HOME/.gitconfig.local"

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	if [ ! -e $FILE_PATH ] || [ -z "$FILE_PATH" ]; then
		print_in_purple "\n  • Setting up gitconfig\n\n"

		ask "What is your github author name? "
		AUTHORNAME="$(get_answer)"

		ask "What is you github email? "
		EMAIL="$(get_answer)"

		printf \
			"[user]
                    name = %s
                    email = %s" \
			$AUTHORNAME \
			$EMAIL \
			>>$FILE_PATH
	fi

	print_result $? "$FILE_PATH"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
	print_in_purple "\n ‣ Create local config files\n\n"
	create_gitconfig_local
	create_node_local
	create_java_local
	create_zsh_local
	create_aliases_local
}

main
