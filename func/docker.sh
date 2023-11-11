#!/bin/bash
#

get_docker_ip() {
	docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$@"
}
