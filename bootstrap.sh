#!/bin/bash
#
#
# bootstrap.sh
# ---
# install the dotfiles on the current system
#

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "./utils.sh"

declare -r REPOSITORY="emma-campbell/dotfiles"
declare -r ORIGIN="git@github.com:$REPOSITORY.git"
declare -r TARBALL="https://github.com/$REPOSITORY/tarball/master"
declare -r UTILS="https://raw.githubusercontent.com/$REPOSITORY/master/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare DOTFILES="$HOME/.dotfiles"
declare skipQuestions=false

# ----------------------------------------------------------------------
# | Helper Functions                                                   |
# ----------------------------------------------------------------------

download() {

	local url="$1"
	local output="$2"

	if command -v "curl" &>/dev/null; then

		curl -LsSo "$output" "$url" &>/dev/null
		#     │││└─ write output to file
		#     ││└─ show error messages
		#     │└─ don't show the progress meter
		#     └─ follow redirects

		return $?

	elif command -v "wget" &>/dev/null; then

		wget -qO "$output" "$url" &>/dev/null
		#     │└─ write output to file
		#     └─ don't show output

		return $?
	fi

	return 1

}

download_dotfiles() {

	local tmpFile=""

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	print_in_purple "\n • Download and extract archive\n\n"

	tmpFile="$(mktemp /tmp/XXXXX)"

	download "$TARBALL" "$tmpFile"
	print_result $? "Download archive" "true"

	printf "\n"
	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	if ! $skipQuestions; then

		ask_for_confirmation "Do you want to store the dotfiles in '$DOTFILES'?"

		if ! answer_is_yes; then
			DOTFILES=""
			while [ -z "$DOTFILES" ]; do
				ask "Please specify another location for the dotfiles (path): "
				DOTFILES="$(get_answer)"
			done
		fi

		# Ensure the `dotfiles` directory is available

		while [ -e "$DOTFILES" ]; do
			ask_for_confirmation "'$DOTFILES' already exists, do you want to overwrite it?"
			if answer_is_yes; then
				rm -rf "$DOTFILES"
				break
			else
				DOTFILES=""
				while [ -z "$DOTFILES" ]; do
					ask "Please specify another location for the dotfiles (path): "
					DOTFILES="$(get_answer)"
				done
			fi
		done

		printf "\n"

	else
		rm -rf "$DOTFILES" &>/dev/null

	fi

	mkdir -p "$DOTFILES"
	print_result $? "Create '$DOTFILES'" "true"

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	# Extract archive in the `dotfiles` directory.

	extract "$tmpFile" "$DOTFILES"
	print_result $? "Extract archive" "true"

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	rm -rf "$tmpFile"
	print_result $? "Remove archive"

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	cd "$DOTFILES/os" ||
		return 1
}

download_utils() {

	local tmpFile=""

	tmpFile="$(mktemp /tmp/XXXXX)"

	download "$UTILS" "$tmpFile" &&
		. "$tmpFile" &&
		rm -rf "$tmpFile" &&
		return 0

	return 1

}

extract() {

	local archive="$1"
	local outputDir="$2"

	if command -v "tar" &>/dev/null; then
		tar -zxf "$archive" --strip-components 1 -C "$outputDir"
		return $?
	fi

	return 1

}

verify_os() {

	declare -r MINIMUM_MACOS_VERSION="10.10"
	declare -r MINIMUM_UBUNTU_VERSION="18.04"

	local os_name="$(get_os)"
	local os_version="$(get_os_version)"

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	# Check if the OS is `macOS` and
	# it's above the required version.

	if [ "$os_name" == "macos" ]; then
		return 0
	else
		return 1
	fi

}

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

	# Ensure that the following actions
	# are made relative to this file's path.

	cd "$(dirname "${BASH_SOURCE[0]}")" ||
		exit 1

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	# Load utils

	if [ -x "utils.sh" ]; then
		. "utils.sh" || exit 1
	fi

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	# Ensure the OS is supported and
	# it's above the required version.

	verify_os ||
		exit 1

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	skip_questions "$@" &&
		skipQuestions=true

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	ask_for_sudo

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	./symlinks/local.sh

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	./ssh.sh

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	"./os/main.sh"

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	for f in symlinks/*.sh; do
		"./$f" "$@"
	done

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	source ~/.zshrc
}

main "$@"
