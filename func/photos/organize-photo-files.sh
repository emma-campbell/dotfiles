#!/bin/bash
#
# Organize Fujifilm photo files in a source directory into raw/ and jpeg/
# subdirectories based on file type (.RAF vs .JPG/.JPEG).
#
# Usage: organize_photos /path/to/source
#    or: ./organize-photo-files.sh /path/to/source
#
# output:
# /path/to/source
# ├── raw
# │   ├── file_1.RAF
# │   ├── file_2.RAF
# │   └── ...
# ├── jpeg
#    ├── file_1.JPG
#    ├── file_2.JPG
#    └── ...

organize_photos() {
	local src="${1:-}"

	if [[ -z "$src" || ! -d "$src" ]]; then
		echo "usage: organize_photos /path/to/source" >&2
		return 1
	fi

	mkdir -p "$src/raw" "$src/jpeg"

	local file dest locked
	for file in "$src"/*; do
		[[ -f "$file" ]] || continue
		case "$file" in
			*.[Rr][Aa][Ff]) dest="$src/raw" ;;
			*.[Jj][Pp][Gg]|*.[Jj][Pp][Ee][Gg]) dest="$src/jpeg" ;;
			*) continue ;;
		esac

		# In-camera "protected" photos carry the locked (uchg) flag, which
		# blocks rename. Unlock, move, then restore the flag.
		locked=""
		if [[ "$(stat -f %Sf "$file")" == *uchg* ]]; then
			locked=1
			chflags nouchg "$file"
		fi
		mv -n "$file" "$dest/"
		if [[ -n "$locked" ]]; then
			if [[ -e "$file" ]]; then
				chflags uchg "$file"
			else
				chflags uchg "$dest/${file##*/}"
			fi
		fi
	done

	echo "raw:  $(find "$src/raw" -type f | wc -l | tr -d ' ') files"
	echo "jpeg: $(find "$src/jpeg" -type f | wc -l | tr -d ' ') files"
}

# Run directly (not sourced): execute with the given args.
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	organize_photos "$@"
fi
