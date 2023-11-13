#!/bin/bash
#
#
#

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../utils.sh"

link_func() {

	local src=""
	local dst=""
	local skipQuestions=false
	local name=""

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	skip_questions "$@" &&
		skipQuestions=true

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	src="$HOME/.dotfiles/func"
	dst="$HOME/.$(printf "%s" "$src" | sed "s/.*\/\(.*\)/\1/g")"

	if [ ! -d "$dst" ] || $skipQuestions; then
		execute \
			"ln -s $src $dst" \
			"$dst → $src"

	elif [ "$(readlink "$dst")" == "$src" ]; then
		print_success "$dst → $src"
	else

		if ! $skipQuestions; then

			ask_for_confirmation "'$dst' already exists, do you want to overwrite it?"
			if answer_is_yes; then

				rm -rf "$dst"

				execute \
					"ln -s $src $dst" \
					"$dst → $src"

			else
				print_error "$dst → $src"
			fi

		fi

	fi
}

print_in_purple "\n • Create func dir symbolic link\n\n"
link_func "$@"
