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

	for f in config/*; do
		sourceFile="$(pwd)/$i"

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

main
