#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_gh_config_link() {

	declare -a FILES_TO_SYMLINK=(
		"git/gh"
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
		targetFile="$HOME/.config/$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

		if [ ! -d "$HOME/.config" ]; then
			mkdir -p "$HOME/.config"
		fi

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

create_symlinks() {

	declare -a FILES_TO_SYMLINK=(
		"git/gitconfig"
		"git/gitignore"
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
	print_in_purple "\n • Create git links\n\n"
	create_symlinks "$@"
	create_gh_config_link "$@"
}

main "$@"
