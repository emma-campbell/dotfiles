# !/bin/bash
#
# symlink all window management related files
# (mainly my aerospace config)
#


cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../utils.sh"


create_symlinks() {
    local src=""
    local dst=""
    local skipQuestions=false

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	skip_questions "$@" &&
		skipQuestions=true

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for f in ../window/*; do
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

print_in_purple "\n • Create window management symbolic links\n\n"
create_symlinks "$@"
