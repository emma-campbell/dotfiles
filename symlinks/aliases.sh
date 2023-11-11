#!/bin/bash
#
#
#

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../utils.sh"

link_aliases() {

	local f=""
	local src=""
	local dst=""
	local skipQuestions=false
	local name=""
	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	skip_questions "$@" &&
		skipQuestions=true

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	for f in ../aliases/aliases.*; do
		sourceFile="$(pwd)/$f"
		targetFile="$HOME/.$(printf "%s" "$f" | sed "s/.*\/\(.*\)/\1/g")"

		if [ ! -d "$targetFile" ] || $skipQuestions; then

			execute \
				"ln -s $sourceFile $targetFile" \
				"$targetFile → $sourceFile"

		elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
			print_success "$targetFile → $sourceFile"
		else

			if ! $skipQuestions; then

				ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
				if answer_is_yes; then

					rm -rf "$targetFile"

					execute \
						"ln -s $sourceFile $targetFile" \
						"$targetFile → $sourceFile"

				else
					print_error "$targetFile → $sourceFile"
				fi

			fi

		fi
	done
}

print_in_purple "\n • Create aliases symbolic links\n\n"
link_aliases "$@"
