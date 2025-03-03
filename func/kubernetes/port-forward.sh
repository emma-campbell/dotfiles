#!/bin/bash
#
# Script for port-forwarding different hugo services

function pf() {
	local namespace=$1
	local deployment=$2
	local port=$3

	echo $namespace
	echo $deployment
	echo $port

	kubectl port-forward $deployment "$port:$port" -n $namespace
}
