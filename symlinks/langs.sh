#!/bin/bash

printf "%s" "$(dirname "$BASH_SOURCE[0]")"

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_symlinks() {

	declare -a FILES_TO_SYMLINK=(
		"lang/node"
		"lang/java"
	)

	local i=""
	local sourceFile=""
	local targetFile=""
	local skipQuestions=false

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	skip_questions "$@" &&
		skipQuestions=true

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	for i in "${FILES_TO_SYMLINK[@]}"; do

		sourceFile="$(cd .. && pwd)/$i"
		targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

		if [ ! -e "$targetFile" ] || $skipQuestions; then

			execute \
				"ln -fs $sourceFile $targetFile" \
				"$targetFile → $sourceFile"

		elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
			print_success "$targetFile → $sourceFile"
		else

			if ! $skipQuestions; then

				ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
				if answer_is_yes; then

					rm -rf "$targetFile"

					execute \
						"ln -fs $sourceFile $targetFile" \
						"$targetFile → $sourceFile"

				else
					print_error "$targetFile → $sourceFile"
				fi

			fi

		fi

	done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
	print_in_purple "\n • Create language symbolic links\n\n"
	create_symlinks "$@"
}

main "$@"