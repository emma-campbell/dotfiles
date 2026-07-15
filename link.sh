#!/bin/bash
#
# link.sh
# ---
# stow the dotfile packages into place:
#
#   config/ → ~/.config      (zsh, git, nvim, ...)
#   home/   → ~              (.zshenv, .calibre.sh)
#   macos/  → ~/.config      (iterm2, karabiner — macOS only)
#
# usage: ./link.sh [-y] [--cleanup]
#
#   --cleanup   also remove legacy symlinks from the pre-stow layout
#               (anything in ~ or ~/.config that points into ~/.dotfiles
#               but is no longer managed by a stow package)

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "./utils.sh"

declare -r DOTFILES_DIR="$(pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Symlinks created by the old `symlinks/*.sh` scripts. Only removed if
# they are symlinks that resolve into the dotfiles repo (or dangle there).

declare -a LEGACY_HOME_LINKS=(
	".zshrc"
	".aliases"
	".aliases.docker"
	".aliases.files"
	".aliases.lazy"
	".aliases.network"
	".aliases.python"
	".aliases.traverse"
	".aliases.utils"
	".aliases.local"
	".node"
	".java"
	".python"
	".ruby"
	".rust"
	".terraform"
	".paths"
	".prompt"
	".prompt.json"
	".fetch.jsonc"
	".func"
	".gitconfig"
	".gitignore"
	".curlrc"
	".aerospace.toml"
	".calibre.sh"
	".ghost.txt"
)

declare -a LEGACY_CONFIG_LINKS=(
	"nvim"
	"vscode"
	"gh"
	"iterm2"
	"karabiner"
)

remove_if_legacy_link() {
	local target="$1"

	if [ -L "$target" ]; then
		case "$(readlink "$target")" in
		*/.dotfiles/*)
			rm "$target"
			print_result $? "removed $target"
			;;
		esac
	fi
}

cleanup_legacy_links() {
	print_in_purple "\n • Remove legacy symlinks\n\n"

	local name=""

	for name in "${LEGACY_HOME_LINKS[@]}"; do
		remove_if_legacy_link "$HOME/$name"
	done

	for name in "${LEGACY_CONFIG_LINKS[@]}"; do
		remove_if_legacy_link "$HOME/.config/$name"
	done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_gitconfig_local() {
	declare -r FILE_PATH="$HOME/.gitconfig.local"

	if [ ! -e "$FILE_PATH" ]; then
		print_in_purple "\n • Setting up gitconfig\n\n"

		ask "What is your github author name? "
		AUTHORNAME="$(get_answer)"

		ask "What is you github email? "
		EMAIL="$(get_answer)"

		printf \
			"[user]
                    name = %s
                    email = %s" \
			"$AUTHORNAME" \
			"$EMAIL" \
			>>"$FILE_PATH"
	fi

	print_result $? "$FILE_PATH"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

stow_packages() {
	print_in_purple "\n • Stow dotfile packages\n\n"

	if ! cmd_exists "stow"; then
		if cmd_exists "brew"; then
			execute "brew install stow" "install stow"
		else
			print_error "stow is not installed (and brew is unavailable)"
			return 1
		fi
	fi

	mkdir -p "$HOME/.config"

	execute \
		"stow --dir='$DOTFILES_DIR' --target='$HOME/.config' --restow config" \
		"~/.config ← config/"

	execute \
		"stow --dir='$DOTFILES_DIR' --target='$HOME' --restow home" \
		"~ ← home/"

	if [ "$(get_os)" == "macos" ]; then
		execute \
			"stow --dir='$DOTFILES_DIR' --target='$HOME/.config' --restow macos" \
			"~/.config ← macos/"
	fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
	local doCleanup=false
	local arg=""

	for arg in "$@"; do
		if [ "$arg" == "--cleanup" ]; then
			doCleanup=true
		fi
	done

	if $doCleanup; then
		cleanup_legacy_links
	fi

	stow_packages

	create_gitconfig_local
}

main "$@"
