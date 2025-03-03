#!/bin/bash
#
# Script for gettings logs for a given Hugo resource
#

function logs() {
	local ns=$1
	local c=$2

	kubectl logs $c -n $ns
}
