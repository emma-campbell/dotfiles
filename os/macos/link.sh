#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../../utils.sh"

link_config_dirs() {
	for f in config/*; do
		sourceFile="$(
			pwd
		)/$f"

		if [ ! -d "$HOME/.config" ]; then
			mkdir "$HOME/.config"
		fi

		targetFile="$HOME/.config/$(printf "%s" "$f" | sed "s/.*\/\(.*\)/\1/g")"

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

link_aliases() {
	sourceFile="$(
		pwd
	)/aliases"
	targetFile="$HOME/.$(printf "%s" "$sourceFile" | sed "s/.*\/\(.*\)/\1.local/g")"

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
}

print_in_purple "\n   Symbolic Links\n\n"

link_config_dirs
link_aliases
