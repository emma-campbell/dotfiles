#!/bin/bash
#
# Restore a previously deleted and commited file.
#
#

function restore() {
	file=$1
	echo "$1"
	sha=$(git rev-list HEAD -n 1 -- "$1")

	git co "$sha^" $1
}
